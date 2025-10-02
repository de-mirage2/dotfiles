#!/bin/sh

echo $(rg -Nv '^#' ~/.config/hypr/scripts/splashes.txt | shuf -n 1)
