#!/usr/bin/env bash
# Preview script para vifm con soporte para batcat + chafa
# - Si estás en Zellij: usa chafa (ASCII art)
# - Si no: podrías extender a ueberzugpp/inline images

file="$1"
mimetype=$(file --mime-type -Lb "$file")

# Detectar si estamos en Zellij
in_zellij=false
if [ -n "$ZELLIJ_SESSION_NAME" ] || [ -n "$ZELLIJ" ]; then
  in_zellij=true
fi

case "$mimetype" in
# Archivos de texto
text/* | application/json | application/xml)
  batcat --style=plain --color=always --wrap=never --pager=never "$file"
  ;;

# Imágenes
image/*)
  if $in_zellij; then
    # Mostrar en ASCII
    chafa -f symbols -s 80x40 "$file"
  else
    # Placeholder para ueberzugpp o inline images
    chafa -f symbols -s 80x40 "$file"
  fi
  ;;

# PDFs
application/pdf)
  if command -v pdftoppm >/dev/null; then
    tmp="/tmp/vifm-pdf-${RANDOM}"
    pdftoppm -png -singlefile -scale-to 320 "$file" "$tmp"
    chafa -f symbols -s 120x60 "${tmp}.png"
    rm -f "${tmp}.png"
  else
    pdftotext "$file" - | head -n 100 | batcat --style=plain --color=always
  fi
  ;;

# Archivos comprimidos
application/zip | application/x-tar | application/x-bzip2 | application/x-gzip | application/x-7z-compressed)
  atool -l "$file"
  ;;

# Audio / video → mostrar metadatos
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
