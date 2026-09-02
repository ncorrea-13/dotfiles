#!/usr/bin/env bash

fzf_colors="fg:#cdd6f4,bg:#0b0712,hl:#7aa2f7,fg+:#cdd6f4,bg+:#24283b,hl+:#bd93f9,info:#e0af68,prompt:#7aa2f7,pointer:#f7768e,marker:#9ece6a,spinner:#7dcfff,border:#7aa2f7"

laptop_output="eDP-1"
external_output=$(swaymsg -t get_outputs | jq -r '.[].name' | grep -v -x "$laptop_output" | head -n 1)

if [ -z "$external_output" ]; then
  notify-send "Pantallas" "No hay un segundo monitor conectado"
  exit 0
fi

notebook=$' Notebook'
monitor=$' Monitor'
dual=$' Dualscreen'

choice=$(printf '%s\n%s\n%s\n' "$notebook" "$monitor" "$dual" |
  fzf --prompt="Pantalla > " --layout=reverse --border --color="$fzf_colors")

[ -z "$choice" ] && exit 0

transform="normal"
if [ "$choice" = "$monitor" ] || [ "$choice" = "$dual" ]; then
  horizontal=$' Horizontal'
  vertical=$' Vertical'
  orientation=$(printf '%s\n%s\n' "$horizontal" "$vertical" |
    fzf --prompt="Orientación > " --layout=reverse --border --color="$fzf_colors")
  [ "$orientation" = "$vertical" ] && transform="270"
fi

case "$choice" in
"$notebook")
  swaymsg output "$laptop_output" enable res 1366x768 pos 0 0
  swaymsg output "$external_output" disable
  ;;
"$monitor")
  swaymsg output "$external_output" enable res 1920x1080 pos 0 0 transform "$transform"
  swaymsg output "$laptop_output" disable
  ;;
"$dual")
  swaymsg output "$laptop_output" enable res 1366x768 pos 0 0
  swaymsg output "$external_output" enable res 1920x1080 pos 1366 0 transform "$transform"
  ;;
esac

killall -q waybar
if [ "$choice" = "$dual" ] && [ "$transform" = "270" ]; then
  tmp_config=$(mktemp --suffix=.jsonc)
  sed "1a\\  \"output\": [\"$laptop_output\"]," ~/.config/waybar/config.jsonc >"$tmp_config"
  setsid waybar -c "$tmp_config" -s ~/.config/waybar/style.css >/dev/null 2>&1 &
else
  setsid waybar >/dev/null 2>&1 &
fi

notify-send "Pantallas" "Configuración aplicada: $choice"
