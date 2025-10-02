#!/bin/bash

CURR=$(pgrep -xa waybar)

if [[ $CURR != "" ]]; then
  killall waybar
else
  waybar
fi
