#!/bin/bash

SOCKET="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

socat - UNIX-CONNECT:"$SOCKET" | while read -r line; do
  if [[ "$line" == workspace* || "$line" == activespecial* ]]; then
    echo "Workspace event received: $line"
    echo "Calling custom/workspace refresh."
    pkill -RTMIN+1 waybar
  fi
done
