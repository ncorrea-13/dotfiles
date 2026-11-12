#!/bin/sh

state_file="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/sway-idle-inhibited"

case "${1:-status}" in
  toggle)
    if [ -e "$state_file" ]; then
      rm "$state_file"
    else
      : > "$state_file"
    fi
    ;;
  status) ;;
  *) exit 2 ;;
esac

if [ -e "$state_file" ]; then
  printf '%s\n' '{"text":"\uf0f4","tooltip":"Keep awake: on","class":"activated"}'
else
  printf '%s\n' '{"text":"\udb83\udfaa","tooltip":"Keep awake: off","class":"deactivated"}'
fi
