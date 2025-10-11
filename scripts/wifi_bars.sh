#!/bin/bash

wifi_icons=("󰤯 " "󰤟 " "󰤢 " "󰤥 " "󰤨 ")
no_wifi_icon="󰤭 "
signal=$(nmcli -f IN-USE,SIGNAL dev wifi list | awk '$1=="*" {print $2}')
output="$no_wifi_icon"

# There are 5 wifi icons
# Seperate percentage to 5 levels(buckets), (0, 20), (20, 40), (40, 60), (60, 80), (80, 100)
# Start from the top bucket (80,100) and continue to the next ones in descending order
# If the signal is higher than the lower limit of the current bucket, assign the corresponding icon to output
# else continue to the next bucket
for ((i = ${#wifi_icons[@]} - 1; i >= 0; i--)); do
  lower_limit=$((i * 20))

  # if not connected or signal = 0
  if [[ -z "$signal" || $signal -eq 0 ]]; then
    output="$no_wifi_icon"
    break
  fi

  if [ "$signal" -gt $lower_limit ]; then
    output=${wifi_icons[i]}
    break
  fi

done

echo "$output"

# alternative icon
# # Convert signal to bars (1 to 5)
# if [ "$SIGNAL" -ge 80 ]; then
#   bars=5
# elif [ "$SIGNAL" -ge 60 ]; then
#   bars=4
# elif [ "$SIGNAL" -ge 40 ]; then
#   bars=3
# elif [ "$SIGNAL" -ge 20 ]; then
#   bars=2
# else
#   bars=1
# fi
#
# # Optional: Visual representation
# symbols=("▁" "▂" "▃" "▄" "▅" "▆" "▇" "█")
# visual=$(printf "%s" "${symbols[@]: -$bars}")
#
# # Output result
# echo "Signal: $SIGNAL%, Bars: $bars $visual"
