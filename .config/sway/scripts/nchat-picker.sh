#!/usr/bin/env bash

fzf_colors="fg:#cdd6f4,bg:#0b0712,hl:#7aa2f7,fg+:#cdd6f4,bg+:#24283b,hl+:#bd93f9,info:#e0af68,prompt:#7aa2f7,pointer:#f7768e,marker:#9ece6a,spinner:#7dcfff,border:#7aa2f7"

choice=$(printf "Telegram\nSignal\nWhatsApp\nWhatsApp Work\n" |
  fzf --prompt="nchat > " --layout=reverse --border --color="$fzf_colors")
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
