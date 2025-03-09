#!/usr/bin/env bash
# Source : https://github.com/ericmurphyxyz/rofi-wifi-menu
notify-send "Getting list of available Wi-Fi networks..."

# Get a list of available wifi connections and morph it into a nice-looking list
wifi_list=$(nmcli --fields "SECURITY,SSID" device wifi list | sed 1d | sed 's/  */ /g' | sed -E "s/WPA*.?\S/ /g" | sed "s/^--/ /g" | sed "s/  //g" | sed "/--/d")

# Get the list of saved connections
saved_connections=$(nmcli -g NAME connection)

# Get the currently active connection
active_connection=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)

# Modify the wifi_list to include icons for saved and active connections
wifi_list=$(echo "$wifi_list" | while read -r line; do
  ssid=$(echo "$line" | awk '{print $NF}')
  if [[ "$saved_connections" == *"$ssid"* ]]; then
    if [[ "$ssid" == "$active_connection" ]]; then
      echo " $line" # Icon for active connection
    else
      echo " $line" # Icon for saved connection
    fi
  else
    echo "$line"
  fi
done)

connected=$(nmcli -fields WIFI g)
if [[ "$connected" =~ "enabled" ]]; then
  toggle="󰖪  Disable Wi-Fi"
elif [[ "$connected" =~ "disabled" ]]; then
  toggle="󰖩  Enable Wi-Fi"
fi

# Use rofi to select wifi network
chosen_network=$(echo -e "$toggle\n$wifi_list" | uniq -u | rofi -dmenu -theme $HOME/.config/rofi/wifimenu/wifi-style.rasi -i -selected-row 1 -p "Wi-Fi SSID: ")
# Get name of connection
read -r chosen_id <<<"${chosen_network:3}"

if [ "$chosen_network" = "" ]; then
  exit
elif [ "$chosen_network" = "󰖩  Enable Wi-Fi" ]; then
  nmcli radio wifi on
elif [ "$chosen_network" = "󰖪  Disable Wi-Fi" ]; then
  nmcli radio wifi off
else
  # Message to show when connection is activated successfully
  success_message="You are now connected to the Wi-Fi network \"$chosen_id\"."
  if [[ $(echo "$saved_connections" | grep -w "$chosen_id") = "$chosen_id" ]]; then
    nmcli connection up id "$chosen_id" | grep "successfully" && notify-send "Connection Established" "$success_message"
  else
    if [[ "$chosen_network" =~ "" ]]; then
      wifi_password=$(rofi -dmenu -p "Password: ")
    fi

    if nmcli device wifi connect "$chosen_id" password "$wifi_password"; then
      notify-send "Connection Established" "$success_message"
      nmcli connection modify id "$chosen_id" wifi-security.psk "$wifi_password"
      nmcli connection up id "$chosen_id"
    else
      notify-send "Connection Failed" "Failed to connect to the Wi-Fi network \"$chosen_id\"."
      nmcli connection delete "$chosen_id"
    fi
  fi
fi
