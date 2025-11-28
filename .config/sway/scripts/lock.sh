#!/bin/bash
swayidle \
  timeout 30 "swaylock-script --grace 10 --fade-in 4" \
  timeout 40 'swaymsg "output * dpms off"' \
  resume 'swaymsg "output * dpms on"' \
  before-sleep "swaylock-script"
