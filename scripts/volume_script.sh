#!/bin/bash

# 
# 
# 
# 
# 

icon=""
change_percent=2
output=""


case $BUTTON in 
# left click
1) wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle ;;
# scroll up
4) wpctl set-volume @DEFAULT_AUDIO_SINK@ $change_percent%- ;;
#scroll down
5) wpctl set-volume @DEFAULT_AUDIO_SINK@ $change_percent%+ ;;
esac

vol_line=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null)
volume=$(echo "$vol_line" | awk '/Volume/ {printf "%.0f\n", $2*100}')
is_muted=$(echo "$vol_line" | awk '/Volume/ {printf $3}')
#icon="Vol:"

if [ -z "$is_muted" ]; then
  icon=""
else
  icon=""
fi

# add necessary spaces
if [ $volume -lt 10 ]; then
  icon="$icon   " 
elif [ $volume -lt 100 ]; then
  icon="$icon  " 
else
  icon="$icon " 
fi

output="$icon$volume%"


echo "$output"
