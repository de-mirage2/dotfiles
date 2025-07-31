#!/bin/bash

if [ -z "$@" ]; then
  if [ -z $(cliphist list) ]; then
    echo 'empty'
  else
    cliphist list
  fi
else
  if [ "$ROFI_RETV" -eq 10 ]; then
    cliphist delete-query <<< "$@" # not working, $ROFI_RETV never equals 10?
  else 
    cliphist decode <<< "$@" | wl-copy
  fi
fi
