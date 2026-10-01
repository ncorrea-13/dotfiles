#!/usr/bin/env bash

source ~/.config/sway/scripts/menu.sh

laptop_output="eDP-1"
external_output=$(swaymsg -t get_outputs | jq -r '.[].name' | grep -v -x "$laptop_output" | head -n 1)

if [ -z "$external_output" ]; then
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

case "$choice" in
"$notebook")
  swaymsg output "$laptop_output" enable res 1366x768 pos 0 0
  swaymsg output "$external_output" disable
  ;;
"$monitor")
  swaymsg output "$external_output" enable res 1920x1080 pos 0 0 transform "$transform"
  swaymsg output "$laptop_output" disable
  ;;
"$dual")
  swaymsg output "$laptop_output" enable res 1366x768 pos 0 0
  swaymsg output "$external_output" enable res 1920x1080 pos 1366 0 transform "$transform"
  ;;
"$mirror")
  swaymsg output "$laptop_output" enable res 1366x768 pos 0 0
  swaymsg output "$external_output" enable res 1920x1080 pos 1366 0
  setsid wl-mirror --fullscreen-output "$external_output" "$laptop_output" >/dev/null 2>&1 &
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
