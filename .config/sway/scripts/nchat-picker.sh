#!/usr/bin/env bash

source ~/.config/sway/scripts/menu.sh

choice=$(printf "Telegram\nSignal\nWhatsApp\nWhatsApp Work\n" |
  MENU_WIDTH=380 menu -mesg "nchat")
[ -z "$choice" ] && exit 0

case "$choice" in
Telegram) dir="$HOME/.config/nchat-telegram" ;;
Signal) dir="$HOME/.config/nchat-signal" ;;
WhatsApp) dir="$HOME/.config/nchat-whatsapp" ;;
"WhatsApp Work") dir="$HOME/.config/nchat-work" ;;
esac

app_id=$(basename "$dir")

if swaymsg -t get_tree | jq -e --arg id "$app_id" '.. | objects | select(.app_id? == $id)' >/dev/null 2>&1; then
  swaymsg "[app_id=\"$app_id\"] scratchpad show" >/dev/null
  exit 0
fi

swaymsg exec "wezterm --config-file ~/.config/wezterm/nchat-popup.lua --config initial_cols=110 --config initial_rows=34 start --always-new-process --class $app_id -- nchat -d $dir" >/dev/null
