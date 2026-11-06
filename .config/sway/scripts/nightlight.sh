#!/usr/bin/env bash
# Yellow screen filter for Sway, driven by a rofi menu. Backend: gammastep.
# Bound to $mod+Shift+g.
#
# gammastep's `-x` never exits once gamma is unsupported/known (it loops forever),
# so never run it in the foreground: kill the previous instance and let the new
# daemon hold the gamma ramps. Killing the client makes the compositor restore.

source ~/.config/sway/scripts/menu.sh

DAY=6500
NIGHT=3500
LAT=-32.9 # Mendoza
LON=-68.8
STATE="${XDG_RUNTIME_DIR:-/tmp}/nightlight.state"

stop() {
  pkill -9 -x gammastep
  sleep 0.2
}

start() {
  stop
  setsid gammastep -m wayland "$@" >/dev/null 2>&1 &
}

status() {
  if [[ -e "$STATE" ]]; then
    local cur
    cur=$(<"$STATE")
    [[ "$cur" == auto ]] && echo "auto (${NIGHT}K-${DAY}K)" || echo "${cur}K"
  else
    echo "off"
  fi
}

items=(
  "󰖙  Off (${DAY}K)"
  "󰖔  Auto (sunset)"
  "  4500K"
  "  4000K"
  "  3500K"
  "  3000K"
  "  2700K"
)

choice=$(printf '%s\n' "${items[@]}" | MENU_WIDTH=420 menu -mesg "Night light · $(status)")
[[ -z "$choice" ]] && exit 0

case "$choice" in
  *Off*) stop; rm -f "$STATE" ;;
  *Auto*) start -l "$LAT:$LON" -t "$NIGHT:$DAY"; echo auto >"$STATE" ;;
  *K)
    temp="${choice//[^0-9]/}"
    start -O "$temp"
    echo "$temp" >"$STATE"
    ;;
esac
