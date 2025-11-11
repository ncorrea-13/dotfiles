#!/bin/bash

AC_ONLINE=$(cat /sys/class/power_supply/ADP0/online)
if [ "$AC_ONLINE" -eq 1 ]; then
  echo "<span>Connected</span>"
fi
