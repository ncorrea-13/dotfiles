#!/usr/bin/env bash

screenshotdir=~/Pictures/Screenshots
recordingdir=~/Videos/Screencasts
icon=~/.config/sway/scripts/camera.png
file="$screenshotdir/$(date '+%y%m%d-%H%M-%S').png"
mkdir -p "$screenshotdir" "$recordingdir"

fzf_colors="fg:#cdd6f4,bg:#0b0712,hl:#7aa2f7,fg+:#cdd6f4,bg+:#24283b,hl+:#bd93f9,info:#e0af68,prompt:#7aa2f7,pointer:#f7768e,marker:#9ece6a,spinner:#7dcfff,border:#7aa2f7"

area=$'\uf125 Area'
cwin=$'\uf2d0 Window'
full=$'\uf108 Full screen'
copy=$'\uf0c5 Copy'
save=$'\uf0c7 Save'
rec=$'\uf03d Record'

pick() {
  fzf --prompt="$1 > " --layout=reverse --border --color="$fzf_colors"
}

if pgrep -x wf-recorder >/dev/null; then
  pkill -INT -x wf-recorder
  notify-send -i "$icon" --urgency low 'Recording saved'
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
    region=$(swaymsg -t get_tree | jq -r '..|try(.nodes[])?|select(.type == "con" and .visible == true and .focused == true) | "\(.rect.x),\(.rect.y) \(.rect.width)x\(.rect.height)"')
    [ -z "$region" ] && exit 0
    setsid -f wf-recorder -g "$region" -f "$video" >/dev/null 2>&1
    ;;
  "$full")
    setsid -f wf-recorder -f "$video" >/dev/null 2>&1
    ;;
  esac

  notify-send -i "$icon" --urgency low 'Recording started' 'Run again to stop'
  exit 0
fi

dest=$(printf '%s\n%s\n' "$save" "$copy" | pick "Destination")
[ -z "$dest" ] && exit 0

case "$mode" in
"$area")
  if [ "$dest" = "$copy" ]; then
    grim -g "$(slurp)" - | wl-copy && notify-send -i "$icon" --urgency low 'Screenshot copied' || notify-send -i "$icon" 'failed to take screenshot'
  else
    grim -g "$(slurp)" "$file" && notify-send -i "$icon" --urgency low 'Screenshot Taken' || notify-send -i "$icon" 'failed to take screenshot'
  fi
  ;;
"$cwin")
  if [ "$dest" = "$copy" ]; then
    swaymsg -t get_tree | jq -r '..|try(.nodes[])?|select(.type == "con" and .visible == true and .focused == true) | "grim -g \"\(.rect.x),\(.rect.y) \(.rect.width)x\(.rect.height)\" - | wl-copy"' | bash && notify-send -i "$icon" --urgency low 'Screenshot copied' || notify-send -i "$icon" 'failed to take screenshot'
  else
    maim -u -m 5 -i "$(xdotool getactivewindow)" "$file" && notify-send -i "$icon" --urgency low 'Screenshot Taken' || notify-send -i "$icon" 'failed to take screenshot'
  fi
  ;;
"$full")
  if [ "$dest" = "$copy" ]; then
    grim - | wl-copy && notify-send -i "$icon" --urgency low 'Screenshot copied' || notify-send -i "$icon" 'failed to take screenshot'
  else
    grim "$file" && notify-send -i "$icon" --urgency low 'Screenshot Taken' || notify-send -i "$icon" 'failed to take screenshot'
  fi
  ;;
esac
