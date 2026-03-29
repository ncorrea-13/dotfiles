#!/bin/bash

export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=sway

exec dbus-run-session sway
