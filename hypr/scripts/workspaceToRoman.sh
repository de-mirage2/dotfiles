#!/bin/bash

mapfile -t vars < <(hyprctl monitors | rg 'workspace' | rg '\s-?(\d{1,3})\s' -or '$1')
arabic=${vars[0]}
special=${vars[1]}

if [[ special -ne 0 ]]; then
  echo "$(~/.config/hypr/scripts/random-splash.sh ~/.config/hypr/scripts/specialSplashes.txt)" 
  exit 0
fi

# tens=("" "Ⅹ" "ⅩⅩ" "ⅩⅩⅩ" "ⅩⅬ" "Ⅼ" "ⅬⅩ" "ⅬⅩⅩ" "ⅬⅩⅩⅩ" "ⅩⅭ")
#
# units=("" "Ⅰ" "Ⅱ" "Ⅲ" "Ⅳ" "Ⅴ" "Ⅵ" "Ⅶ" "Ⅷ" "Ⅸ" "Ⅹ")

tens=("" "X" "XX" "XXX" "XL" "L" "LX" "LXX" "LXXX" "XC")

units=("" "I" "II" "III" "IV" "V" "VI" "VII" "VIII" "IX" "X")

t=$((arabic / 10))
u=$((arabic % 10))

echo "${tens[$t]}${units[$u]}"
