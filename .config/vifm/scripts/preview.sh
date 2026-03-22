#!/usr/bin/env bash

file="$1"
mimetype=$(file --mime-type -Lb "$file")

case "$mimetype" in
text/* | application/json | application/xml)
  batcat --style=plain --color=always --wrap=never --pager=never "$file"
  ;;

image/*)
  cols="$(tput cols)*2"
  rows="$(tput lines)*2"
  chafa -f symbols -s "${cols}x${rows}" "$file"
  ;;

application/pdf)
  if command -v pdftoppm >/dev/null; then
    tmp="/tmp/vifm-pdf-${RANDOM}"
    pdftoppm -png -f 1 -singlefile -scale-to-x 600 -scale-to-y -1 "$file" "$tmp"
    chafa -f symbols -s 120x60 "${tmp}.png"
    rm -f "${tmp}.png"
  else
    pdftotext "$file" - | head -n 100 | batcat --style=plain --color=always
  fi
  ;;

application/zip | application/x-tar | application/x-bzip2 | application/x-gzip | application/x-7z-compressed)
  atool -l "$file"
  ;;

audio/*)
  exiftool "$file" 2>/dev/null || mediainfo "$file" 2>/dev/null || echo "Archivo multimedia"
  ;;

video/*)
  if command -v ffmpeg >/dev/null; then
    tmp="/tmp/vifm-video-${RANDOM}.png"
    ffmpeg -y -i "$file" -vf "thumbnail,scale=320:240" -frames:v 1 "$tmp" >/dev/null 2>&1
    chafa -f symbols -s 80x40 "$tmp"
    rm -f "$tmp"
  else
    exiftool "$file" 2>/dev/null || mediainfo "$file" 2>/dev/null
  fi
  ;;

*)
  echo "No preview disponible para: $mimetype"
  ;;
esac
