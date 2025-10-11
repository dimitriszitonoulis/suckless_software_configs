#!/bin/bash

# In order for the script to run without entering a password
# the sudoers file must be edited (by using visudo)
# Enter the line below to the sudoers file, where yourusername is your user's username
# yourusername ALL=(root) NOPASSWD: /usr/bin/tlp setcharge 50 60 BAT1, /usr/bin/tlp setcharge 70 80 BAT1, /usr/bin/tlp setcharge 90 100 BAT1

BAT_MODES=(" health " "balanced" "portable")
DEFAULT_MODE="portability"
# CUR_MODE_FILE="$HOME/topbar_scripts/battery_power/bat_mode"
CUR_MODE_FILE="$HOME/.local/state/bat_mode"

# Input: None
# Output: String - the value of the current mode
#     The value is string read from the CUR_MODE_FILE
#     If the file does not exist then the DEFAULT_MODE is returned
# Description: Read the mode file to determine the current mode
get_current_mode() {
  # ignore the comments from the mode file
  if [ -f "$CUR_MODE_FILE" ]; then
    echo $(grep -v "^#" "$CUR_MODE_FILE" | head -n1)
  else
    echo "$DEFAULT_MODE"
  fi
}

# Input: String - the value of the current mode
# Output: String - the value of the next mode
# Description: get the index of the next mode in the BAT_MODES array
get_next_idx() {
  local cur_idx=0
  local cur_mode=$1

  for idx in "${!BAT_MODES[@]}"; do
    if [ $cur_mode = "${BAT_MODES[$idx]}" ]; then
      cur_idx=$idx
      break
    fi
  done
  local next_idx=$(((cur_idx + 1) % ${#BAT_MODES[@]}))
  echo "$next_idx"
}

# Input: String - the value of the battery mode
# Output: 0 if succesfull
# Description: Enters the value of the current mode to the mode file CUR_MODE_FILE
#       If the file does not exist, it creates the file, entering a description
#       and the value of the battery mode
write_mode_file() {
  local bat_mode=$1
  # handle missing mode file
  if [ ! -f "$CUR_MODE_FILE" ]; then
    #printf "# This file is used to retain info about the currently used battery mode\n# It is also used to read the battery mode used before boot\n# tlp does not keep info about the battery charging limits before boot\n" >"$CUR_MODE_FILE"
    printf "# This file is used to retain info about the currently used battery mode" >"$CUR_MODE_FILE"
    echo "$bat_mode" >>"$CUR_MODE_FILE"
    return 0
  else
    # do not overwrite the current mode file with grep, create tmp file
    grep "^#" "$CUR_MODE_FILE" 2>/dev/null >"$CUR_MODE_FILE.tmp"
    echo "$bat_mode" >>"$CUR_MODE_FILE.tmp"
    mv "$CUR_MODE_FILE.tmp" "$CUR_MODE_FILE"
  fi

}

set_tlp_threshold() {
  local mode=$1

  case "$mode" in
  " health ") sudo tlp setcharge 50 60 BAT1 >/dev/null 2>&1 ;;
  "balanced") sudo tlp setcharge 70 80 BAT1 >/dev/null 2>&1 ;;
  "portable") sudo tlp setcharge 90 100 BAT1 >/dev/null 2>&1 ;;
  *) sudo tlp setcharge 90 100 BAT1 >/dev/null 2>&1 ;;
  esac
}

if [ "$BUTTON" = "1" ]; then
  CUR_MODE=$(get_current_mode)
  NEXT_MODE_IDX=$(get_next_idx "$CUR_MODE")
  NEXT_MODE=${BAT_MODES[$NEXT_MODE_IDX]} # change current mode
  write_mode_file "$NEXT_MODE"           # write changes to mode file
  set_tlp_threshold "$NEXT_MODE"         # change to the next mode

  echo "$NEXT_MODE"
else
  CUR_MODE=$(get_current_mode)
  echo "$CUR_MODE"
fi
