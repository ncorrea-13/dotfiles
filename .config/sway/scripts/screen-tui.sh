#!/usr/bin/env bash

source ~/.config/sway/scripts/menu.sh

laptop_output="eDP-1"
mapfile -t externals < <(swaymsg -t get_outputs | jq -r '.[].name' | grep -v -x "$laptop_output")

if [ ${#externals[@]} -eq 0 ]; then
  notify-send "Displays" "No external monitor connected"
  exit 0
fi

notebook=$' Notebook'
monitor=$' Monitor'
dual=$' Dualscreen'
mirror=$' Mirror'

choice=$(printf '%s\n%s\n%s\n%s\n' "$notebook" "$monitor" "$dual" "$mirror" |
  MENU_WIDTH=380 menu -mesg "Display")

[ -z "$choice" ] && exit 0

killall -q wl-mirror

transform="normal"
if [ "$choice" = "$monitor" ] || [ "$choice" = "$dual" ]; then
  horizontal=$' Horizontal'
  vertical=$' Vertical'
  orientation=$(printf '%s\n%s\n' "$horizontal" "$vertical" |
    MENU_WIDTH=380 menu -mesg "Orientation")
  [ "$orientation" = "$vertical" ] && transform="270"
fi

# Place external outputs side by side, left to right, starting at x=$1.
enable_externals() {
  local x=$1 width=1920
  [ "$transform" = "270" ] && width=1080
  for o in "${externals[@]}"; do
    swaymsg output "$o" enable res 1920x1080 pos "$x" 0 transform "$transform"
    x=$((x + width))
  done
}

case "$choice" in
"$notebook")
  swaymsg output "$laptop_output" enable res 1366x768 pos 0 0
  for o in "${externals[@]}"; do swaymsg output "$o" disable; done
  ;;
"$monitor")
  enable_externals 0
  swaymsg output "$laptop_output" disable
  ;;
"$dual")
  swaymsg output "$laptop_output" enable res 1366x768 pos 0 0
  enable_externals 1366
  ;;
"$mirror")
  swaymsg output "$laptop_output" enable res 1366x768 pos 0 0
  enable_externals 1366
  for o in "${externals[@]}"; do
    setsid wl-mirror --fullscreen-output "$o" "$laptop_output" >/dev/null 2>&1 &
  done
  ;;
esac

killall -q waybar
if [ "$choice" = "$dual" ] && [ "$transform" = "270" ]; then
  tmp_config=$(mktemp --suffix=.jsonc)
  sed "1a\\  \"output\": [\"$laptop_output\"]," ~/.config/waybar/config.jsonc >"$tmp_config"
  setsid waybar -c "$tmp_config" -s ~/.config/waybar/style.css >/dev/null 2>&1 &
else
  setsid waybar >/dev/null 2>&1 &
fi

notify-send "Displays" "Applied: $choice"
