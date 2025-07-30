#!/bin/bash

if [ -z "$@" ]; then
  if [ -z $(cliphist list) ]; then
    echo 'empty'
  else
    cliphist list
  fi
else
  # echo $ROFI_RETV
  # echo $@
  if [ "$ROFI_RETV" -eq 3]; then
    cliphist delete <<< "$@" # not working, $ROFI_RETV never equals 3?
  else 
    cliphist decode <<< "$@" | wl-copy
  fi
fi
