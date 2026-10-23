#!/usr/bin/env bash
if [ "$(dunstctl is-paused)" = "true" ]; then
    dunstctl close-all
    dunstctl set-paused false
else
    dunstctl set-paused true
fi
pkill -RTMIN+8 waybar
