#!/usr/bin/env bash

uptime_str="$(uptime -p | sed -e 's/up //g')"
fzf_colors="fg:#cdd6f4,bg:#0b0712,hl:#7aa2f7,fg+:#cdd6f4,bg+:#24283b,hl+:#bd93f9,info:#e0af68,prompt:#7aa2f7,pointer:#f7768e,marker:#9ece6a,spinner:#7dcfff,border:#7aa2f7"

shutdown=$' Shutdown'
reboot=$' Reboot'
hibernate=$' Hibernate'
lock=$' Lock'
suspend=$' Suspend'
logout=$' Logout'

choice=$(printf '%s\n%s\n%s\n%s\n%s\n%s\n' "$shutdown" "$reboot" "$hibernate" "$lock" "$suspend" "$logout" |
  fzf --prompt="Goodbye $USER > " --header="Uptime: $uptime_str" --layout=reverse --border --color="$fzf_colors")

[ -z "$choice" ] && exit 0

confirm() {
  local answer
  answer=$(printf 'Yes\nNo\n' | fzf --prompt="$1? > " --layout=reverse --border --color="$fzf_colors")
  [ "$answer" = "Yes" ]
}

case "$choice" in
"$shutdown") confirm "Shutdown" && loginctl poweroff ;;
"$reboot") confirm "Reboot" && loginctl reboot ;;
"$hibernate") confirm "Hibernate" && loginctl hibernate ;;
"$suspend")
  confirm "Suspend" || exit 0
  command -v mpc &>/dev/null && mpc -q pause
  command -v amixer &>/dev/null && amixer set Master mute
  systemctl suspend
  ;;
"$logout") confirm "Logout" && loginctl terminate-user "$USER" ;;
"$lock") rustlock-script ;;
esac
