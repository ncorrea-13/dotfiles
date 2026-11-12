#!/usr/bin/env bash
idle_inhibitor_file="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/sway-idle-inhibited"
swayidle \
  timeout 600 "if [ ! -e '$idle_inhibitor_file' ]; then bw lock >/dev/null 2>&1; rm -f ~/.cache/bw_session ~/.cache/bw_session_time; rustlock-script --grace 10 --fade-in 4; fi" \
  timeout 610 "if [ ! -e '$idle_inhibitor_file' ]; then swaymsg 'output * dpms off'; fi" \
  resume 'swaymsg "output * dpms on"' \
  before-sleep 'bw lock >/dev/null 2>&1; rm -f ~/.cache/bw_session ~/.cache/bw_session_time; rustlock-script'
