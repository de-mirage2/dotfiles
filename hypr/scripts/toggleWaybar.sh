#!/bin/sh

CURR=$(pgrep -xa waybar)

if [[ $CURR != "" ]]; then
  killall waybar
else
  waybar
fi
