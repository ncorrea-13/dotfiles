#!/usr/bin/env bash
swayidle \
  timeout 600 'bw lock >/dev/null 2>&1; rm -f ~/.cache/bw_session ~/.cache/bw_session_time; rustlock-script --grace 10 --fade-in 4' \
  timeout 610 'swaymsg "output * dpms off"' \
  resume 'swaymsg "output * dpms on"' \
  before-sleep 'bw lock >/dev/null 2>&1; rm -f ~/.cache/bw_session ~/.cache/bw_session_time; rustlock-script'
