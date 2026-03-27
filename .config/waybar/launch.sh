#!/bin/bash

killall -q waybar

while [ ! -S /run/user/1000/pulse/native ]; do
  echo "Esperando al socket de audio..."
  sleep 0.5
done

waybar &
