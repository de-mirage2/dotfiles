#!/bin/bash

mapfile -t vars < <(hyprctl monitors | rg 'workspace' | rg '\s-?(\d{1,3})\s' -or '$1')
arabic=${vars[0]}
special=${vars[1]}

# echo "arabic = $arabic special = $special"

if [[ special -ne 0 ]]; then
  echo 0
  exit 1
fi

tens=("" "Ⅹ" "ⅩⅩ" "ⅩⅩⅩ" "ⅩⅬ" "Ⅼ" "ⅬⅩ" "ⅬⅩⅩ" "ⅬⅩⅩⅩ" "ⅩⅭ")

units=("" "Ⅰ" "Ⅱ" "Ⅲ" "Ⅳ" "Ⅴ" "Ⅵ" "Ⅶ" "Ⅷ" "Ⅸ" "Ⅹ")

t=$((arabic / 10))
u=$((arabic % 10))

echo "${tens[$t]}${units[$u]}"
