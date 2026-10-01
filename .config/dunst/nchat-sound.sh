#!/usr/bin/env bash
[ "$(dunstctl is-paused)" = "true" ] && exit 0
pw-play /usr/share/sounds/freedesktop/stereo/message-new-instant.oga &>/dev/null &
