#!/usr/bin/env bash

screenshotdir=~/Pictures/Screenshots
recordingdir=~/Videos/Screencasts
icon=~/.config/sway/scripts/camera.png
file="$screenshotdir/$(date '+%y%m%d-%H%M-%S').png"
mkdir -p "$screenshotdir" "$recordingdir"

source ~/.config/sway/scripts/menu.sh

area=$'\uf125 Area'
cwin=$'\uf2d0 Window'
full=$'\uf108 Full screen'
copy=$'\uf0c5 Copy'
save=$'\uf0c7 Save'
rec=$'\uf03d Record'

pick() {
  MENU_WIDTH=380 menu -mesg "$1"
}

notify() {
  notify-send -a screenshot -i "$icon" "$@"
}

shot() {
  if [ "$dest" = "$copy" ]; then
    grim "$@" - | wl-copy && notify -u low 'Screenshot copied' || notify 'Screenshot failed'
  else
    grim "$@" "$file" && notify -u low 'Screenshot saved' || notify 'Screenshot failed'
  fi
}

hide_console() {
  sleep 0.1
}

if pgrep -x wf-recorder >/dev/null; then
  pkill -INT -x wf-recorder
  notify -u low 'Recording saved'
  exit 0
fi

mode=$(printf '%s\n%s\n%s\n%s\n' "$area" "$cwin" "$full" "$rec" | pick "Screenshot")
[ -z "$mode" ] && exit 0

if [ "$mode" = "$rec" ]; then
  video="$recordingdir/$(date '+%y%m%d-%H%M-%S').mp4"
  geom=$(printf '%s\n%s\n%s\n' "$area" "$cwin" "$full" | pick "Record")
  [ -z "$geom" ] && exit 0

  case "$geom" in
  "$area")
    region="$(slurp)"
    [ -z "$region" ] && exit 0
    setsid -f wf-recorder -g "$region" -f "$video" >/dev/null 2>&1
    ;;
  "$cwin")
    hide_console
    region=$(swaymsg -t get_tree | jq -r '..|try(.nodes[])?|select(.type == "con" and .visible == true and .focused == true) | "\(.rect.x),\(.rect.y) \(.rect.width)x\(.rect.height)"')
    [ -z "$region" ] && exit 0
    setsid -f wf-recorder -g "$region" -f "$video" >/dev/null 2>&1
    ;;
  "$full")
    setsid -f wf-recorder -f "$video" >/dev/null 2>&1
    ;;
  esac

  notify -u low 'Recording started' 'Run again to stop'
  exit 0
fi

dest=$(printf '%s\n%s\n' "$save" "$copy" | pick "Destination")
[ -z "$dest" ] && exit 0

case "$mode" in
"$area")
  region="$(slurp)"
  [ -z "$region" ] && exit 0
  hide_console
  shot -g "$region"
  ;;
"$cwin")
  hide_console
  region=$(swaymsg -t get_tree | jq -r '..|try(.nodes[])?|select(.type == "con" and .visible == true and .focused == true) | "\(.rect.x),\(.rect.y) \(.rect.width)x\(.rect.height)"')
  [ -z "$region" ] && exit 0
  shot -g "$region"
  ;;
"$full")
  hide_console
  shot
  ;;
esac
