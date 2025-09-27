#!/bin/bash

dbus-monitor "type='signal',interface='org.freedesktop.DBus.Properties'" | \
while read -r line; do
  if [[ "$line" == *"PlaybackStatus"* ]]; then
    read -r next_line
    if [[ "$next_line" == *"Playing"* || "$next_line" == *"Paused"* ]]; then
      pkill -RTMIN+2 waybar
    fi
  fi
done
