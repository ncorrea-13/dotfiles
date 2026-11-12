#!/bin/sh

case "$1" in
  play-pause)
    mpv_command='["cycle","pause"]'
    ;;
  next)
    mpv_command='["playlist-next"]'
    ;;
  previous)
    mpv_command='["playlist-prev"]'
    ;;
  stop)
    mpv_command='["stop"]'
    ;;
  *)
    exit 2
    ;;
esac

if playerctl "$1" 2>/dev/null; then
  exit 0
fi

printf '{"command":%s}\n' "$mpv_command" |
  socat - UNIX-CONNECT:/run/user/1000/mpv.sock >/dev/null 2>&1
