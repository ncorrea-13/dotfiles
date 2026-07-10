#!/usr/bin/env bash

if swaymsg -t get_tree | jq -e '.. | objects | select(.app_id? == "ncspot")' >/dev/null 2>&1; then
  swaymsg '[app_id="ncspot"] scratchpad show'
else
  exec wezterm --config-file ~/.config/wezterm/tui-popup.lua --config initial_cols=100 --config initial_rows=32 start --always-new-process --class ncspot -- ~/.local/bin/ncspot
fi
