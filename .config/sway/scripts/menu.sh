#!/usr/bin/env bash
menu() {
  local out_w side input lines
  input=$(cat)
  lines=$(printf '%s\n' "$input" | wc -l)
  (( lines > 10 )) && lines=10
  out_w=$(swaymsg -t get_outputs | jq '.[] | select(.focused).rect.width')
  side=$(( (out_w - ${MENU_WIDTH:-700}) / 2 ))
  printf '%s\n' "$input" | rofi -dmenu -i -no-custom \
    -theme ~/.config/sway/scripts/menu.rasi \
    -kb-row-down "j,Down,Tab" -kb-row-up "k,Up,ISO_Left_Tab" \
    -kb-row-first "g,Home" -kb-row-last "Shift+g,End" \
    -kb-accept-entry "${MENU_ACCEPT:-l,Return,KP_Enter}" -kb-cancel "${MENU_CANCEL:-q,h,Escape}" \
    -kb-element-next "" -kb-element-prev "" -kb-mode-complete "" \
    -theme-str "mainbox {margin: 0 ${side}px;} listview {lines: ${lines};}" \
    "$@"
}
