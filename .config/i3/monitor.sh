#!/usr/bin/env bash

if xrandr | grep -q "HDMI-1 connected"; then
  xrandr --output HDMI-1 --auto --right-of eDP-1
fi
