#!/usr/bin/env bash
[ "$(swaync-client -D)" = "true" ] && exit 0
pw-play /usr/share/sounds/freedesktop/stereo/message-new-instant.oga &>/dev/null &
