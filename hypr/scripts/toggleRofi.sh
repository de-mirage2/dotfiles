#!/bin/sh

CURR=$(pgrep -xa rofi)

if [[ $CURR != "" ]]; then
  killall rofi
fi

if [[ $CURR != *"$1"* ]]; then
  case $1 in

    emoji)
      rofi -show emoji -no-icons -modi "emoji:rofimoji --action=copy"
      ;;

    drun)
      rofi -show drun -show-icons -modi drun,cliphist:"~/.config/rofi/scripts/rofi-cliphist.sh"
      ;;
  esac
fi
