#!/usr/bin/env bash

uptime_str="$(uptime -p | sed -E 's/up //; s/ days?/d/; s/ hours?/h/; s/ minutes?/m/; s/,//g')"
source ~/.config/sway/scripts/menu.sh

shutdown=$' Shutdown'
reboot=$' Reboot'
hibernate=$' Hibernate'
lock=$' Lock'
suspend=$' Suspend'
logout=$' Logout'

items=("$shutdown" "$reboot" "$hibernate" "$lock" "$suspend" "$logout")

idx=$(for i in "${items[@]}"; do printf "<span size='20pt'>%s</span>\n%s|" "${i%% *}" "${i#* }"; done |
  MENU_ACCEPT="Return,KP_Enter" MENU_CANCEL="q,Escape" MENU_WIDTH=480 menu -sep '|' -eh 3 -markup-rows -format i \
    -kb-row-left "h,Left" -kb-row-right "l,Right" -kb-move-char-back "" -kb-move-char-forward "" \
    -theme-str 'listview {columns: 3; lines: 2; flow: horizontal;} element {padding: 10px 4px;} element-text {horizontal-align: 0.5;}' \
    -mesg "Goodbye $USER · up $uptime_str")

[ -z "$idx" ] && exit 0
choice=${items[$idx]}

confirm() {
  local answer
  answer=$(printf 'Yes\nNo\n' | MENU_WIDTH=380 menu -mesg "$1?")
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
  loginctl suspend
  ;;
"$logout") confirm "Logout" && loginctl terminate-user "$USER" ;;
"$lock") rustlock-script ;;
esac
