#!/usr/bin/env bash

# Current Theme
dir="$HOME/.config/rofi/powermenu/"
theme='style-1'

# CMDs

uptime="$(uptime -p | sed -e 's/up //g')"

# Options
hibernate=''
shutdown=''
reboot=''
lock=''
suspend=''
logout=''
yes=''
no=''

# Rofi CMD
rofi_cmd() {
  rofi -dmenu \
    -p "Goodbye ${USER}" \
    -mesg "Uptime: $uptime" \
    -theme ${dir}/${theme}.rasi
}

# Confirmation CMD
confirm_cmd() {
  rofi -theme-str 'window {location: center; anchor: center; fullscreen: true;}' \
    -theme-str 'mainbox {children: [ "message", "listview" ];}' \
    -theme-str 'listview {columns: 2; lines: 1;}' \
    -theme-str 'element-text {horizontal-align: 0.5;}' \
    -theme-str 'textbox {horizontal-align: 0.5;}' \
    -theme-str 'message {margin: 200px 10px 10px 10px; padding: 10px; border-radius: 20px; background-color: @background-normal; text-color: @foreground-normal;}' \
    -theme-str 'element {padding: 10px; border-radius: 20px; background-color: @background-normal; text-color: @foreground-normal;}' \
    -theme-str 'element selected.normal {background-color: @background-selected; text-color: @foreground-selected;}' \
    -dmenu \
    -p 'Confirmation' \
    -mesg 'Are you Sure?' \
    -theme "${dir}/${theme}.rasi"
}

# Ask for confirmation
confirm_exit() {
  echo -e "$yes\n$no" | confirm_cmd
}

# Pass variables to rofi dmenu
run_rofi() {
  echo -e "$shutdown\n$reboot\n$lock\n$logout\n$suspend\n$hibernate" | rofi_cmd
}

# Execute Command
run_cmd() {
  selected="$(confirm_exit)"
  if [[ "$selected" == "$yes" ]]; then
    case "$1" in
    --shutdown) systemctl poweroff ;;
    --reboot) systemctl reboot ;;
    --hibernate) systemctl hibernate ;;
    --suspend)
      command -v mpc &>/dev/null && mpc -q pause
      command -v amixer &>/dev/null && amixer set Master mute
      systemctl suspend
      ;;
    --logout) loginctl terminate-user "$USER" ;;
    --lock) swaylock-script ;;
    esac
  fi
}

# Actions
chosen="$(run_rofi)"
case "$chosen" in
"$shutdown") run_cmd --shutdown ;;
"$reboot") run_cmd --reboot ;;
"$hibernate") run_cmd --hibernate ;;
"$lock") run_cmd --lock ;;
"$suspend") run_cmd --suspend ;;
"$logout") run_cmd --logout ;;
esac
