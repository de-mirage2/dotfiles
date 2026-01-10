#!/bin/sh

echo "RUNNING REFRESHONWORKSPACECHANGE.SH"

SOCKET="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

echo "SOCKET FOUND AT: $SOCKET"

handle() {
  case "$1" in
    workspacev2*|activespecialv2*)
      echo "Received '$line', Calling custom/workspace refresh."
      pkill -RTMIN+1 waybar
      ;;
  esac
}

socat -U - UNIX-CONNECT:"$SOCKET" | while read -r line; do handle "$line"; done

echo "END OUTPUT"

# echo "RUNNING REFRESHONWORKSPACECHANGE.SH"
#
# SOCKET="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"
#
# echo "SOCKET FOUND"
#
# socat - UNIX-CONNECT:"$SOCKET" | while read -r line; do
#   echo "Line was read!"
#   case "$line" in
#     workspace*|activespecial*)
#       echo "Workspace event received: $line"
#       echo "Calling custom/workspace refresh."
#       pkill -RTMIN+1 waybar
#       ;;
#   esac
# done
