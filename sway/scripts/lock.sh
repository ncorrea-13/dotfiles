#!/bin/bash
swayidle \
  timeout 30 "$HOME/.config/sway/scripts/swaylock.sh --grace 10 --fade-in 4" \
  timeout 40 'swaymsg "output * dpms off"' \
  resume 'swaymsg "output * dpms on"' \
  before-sleep "$HOME/.config/sway/scripts/swaylock.sh"
