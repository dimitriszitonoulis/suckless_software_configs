#!/bin/bash

# 🔅
change_percent=2

case $BUTTON in
4) brightnessctl set $change_percent%- >/dev/null 2>&1 ;;
5) brightnessctl set +$change_percent% >/dev/null 2>&1 ;;
esac

# get brightness after change
brightness_percent=$(brightnessctl i | awk -F '[()%]' '/Current brightness/ {print $2}')

echo "Bri: $brightness_percent%"
