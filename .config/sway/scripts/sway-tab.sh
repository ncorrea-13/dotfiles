#!/usr/bin/env bash

fzf_colors="fg:#cdd6f4,bg:#0b0712,hl:#7aa2f7,fg+:#cdd6f4,bg+:#24283b,hl+:#bd93f9,info:#e0af68,prompt:#7aa2f7,pointer:#f7768e,marker:#9ece6a,spinner:#7dcfff,border:#7aa2f7"

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

selected=$(echo "$windows" | fzf --prompt="Ventana > " --layout=reverse --border --color="$fzf_colors")

if [ ! -z "$selected" ]; then
  workspace=$(echo "$selected" | awk -F'[\[\]]' '{print $2}')
  swaymsg workspace "$workspace"
fi
