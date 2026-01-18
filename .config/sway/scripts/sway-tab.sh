#!/bin/bash

windows=$(swaymsg -t get_tree | jq -r '
  def find_windows(ws):
    if .type == "con" or .type == "floating_con" then
      if .app_id != null then
        "[" + ws + "] \(.app_id)"
      else
        (.nodes[]?, .floating_nodes[]?) | find_windows(ws)
      end
    else
      (.nodes[]?, .floating_nodes[]?) | find_windows(ws)
    end;
  .nodes[] | select(.type == "output") | .nodes[] | select(.type == "workspace") | . as $ws | (.nodes[]?, .floating_nodes[]?) | find_windows($ws.name)
')

selected=$(echo "$windows" | rofi -dmenu -i -p "Ventana" -width 50)

if [ ! -z "$selected" ]; then
  workspace=$(echo "$selected" | awk -F'[\[\]]' '{print $2}')
  swaymsg workspace "$workspace"
fi
