#!/usr/bin/env bash
swayidle \
  timeout 600 "swaylock-script --grace 10 --fade-in 4" \
  timeout 610 'swaymsg "output * dpms off"' \
  resume 'swaymsg "output * dpms on"' \
  before-sleep "swaylock-script"
