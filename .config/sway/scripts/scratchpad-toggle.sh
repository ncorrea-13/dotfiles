#!/usr/bin/env bash
app_id=$1
shift

if swaymsg -t get_tree | jq -e --arg app_id "$app_id" '.. | objects | select(.app_id? == $app_id)' >/dev/null 2>&1; then
  swaymsg "[app_id=\"$app_id\"] scratchpad show"
else
  exec "$@"
fi
