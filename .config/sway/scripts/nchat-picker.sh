#!/usr/bin/env bash

fzf_colors="fg:#cdd6f4,bg:#0b0712,hl:#7aa2f7,fg+:#cdd6f4,bg+:#24283b,hl+:#bd93f9,info:#e0af68,prompt:#7aa2f7,pointer:#f7768e,marker:#9ece6a,spinner:#7dcfff,border:#7aa2f7"
state_file="$HOME/.cache/nchat_account"

choice=$(printf "Telegram\nSignal\nWhatsApp\nWhatsApp Work\n" |
  fzf --prompt="nchat > " --layout=reverse --border --color="$fzf_colors")
[ -z "$choice" ] && exit 0

case "$choice" in
Telegram) dir="$HOME/.config/nchat-telegram" ;;
Signal) dir="$HOME/.config/nchat-signal" ;;
WhatsApp) dir="$HOME/.config/nchat-whatsapp" ;;
"WhatsApp Work") dir="$HOME/.config/nchat-work" ;;
esac

existing="no"
swaymsg -t get_tree | jq -e '.. | objects | select(.app_id? == "nchat")' >/dev/null 2>&1 && existing="yes"
current=$(cat "$state_file" 2>/dev/null)

if [ "$existing" = "yes" ] && [ "$current" = "$choice" ]; then
  swaymsg '[app_id="nchat"] scratchpad show' >/dev/null
  exit 0
fi

[ "$existing" = "yes" ] && swaymsg '[app_id="nchat"] kill' >/dev/null

echo "$choice" >"$state_file"

swaymsg exec "wezterm --config-file ~/.config/wezterm/nchat-popup.lua --config initial_cols=110 --config initial_rows=34 start --always-new-process --class nchat -- nchat -d $dir" >/dev/null
