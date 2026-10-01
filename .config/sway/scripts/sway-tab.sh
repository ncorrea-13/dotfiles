#!/usr/bin/env bash
source ~/.config/sway/scripts/menu.sh

sel=$(swaymsg -t get_tree | jq -r '
  def mru($ws):
    (if .type == "workspace" then .name else $ws end) as $ws
    | if .pid != null then {id, ws: $ws, app: (.app_id // .window_properties.class // "?"), name: (.name // "")}
      else .focus as $f
        | ((.nodes // []) + (.floating_nodes // []))
        | sort_by(.id as $i | $f | indices($i)[0] // 1e9)
        | .[] | mru($ws)
      end;
  [mru("?")]
  | map(select(.ws != "__i3_scratch")) + map(select(.ws == "__i3_scratch") | .ws = "0")
  | .[] | "\(.id)\t[\(.ws)] \(.app) — \(.name)"
' | menu -selected-row 1 -display-columns 2 -display-column-separator $'\t')

[ -n "$sel" ] && swaymsg "[con_id=${sel%%$'\t'*}] focus" >/dev/null
