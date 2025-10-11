#!/bin/bash
# split command output based on commas, get the 2nd field, remove %
bat_percent=$(acpi -b | awk -F', ' '{print $2}' | tr -d '%')
status=$(acpi -b | awk '{print $3}' | tr -d ',')
is_charging=0
#bat_states_tmp=("󰁹" "󰂂" "󰂁" "󰂀" "󰁿" "󰁾" "󰁽" "󰁼" "󰁻" "󰁺")

bat_states=("󰁺" "󰁻" "󰁼" "󰁼" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹")
charging_icon="󱐋"
output=""

if [ "$status" = "Charging" ]; then
  is_charging=1
fi

for ((i = ${#bat_states[@]} - 1; i >= 0; i--)); do
  lower_limit=$((i * 10))
  if [ $bat_percent -gt $lower_limit ]; then
    output=${bat_states[i]}
    # add charging icon
    if [ $is_charging -eq 1 ]; then
      output="$output$charging_icon"
    fi
    output="$output $bat_percent%"
    break
  fi
done

echo "$output"
