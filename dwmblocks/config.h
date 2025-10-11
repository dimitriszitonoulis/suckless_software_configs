// Modify this file to change what commands output to your statusbar, and
// recompile using the make command.
static const Block blocks[] = {
    /*Icon*/ /*Command*/ /*Update Interval*/ /*Update Signal*/

    {"", "$HOME/suckless/scripts/volume_script.sh", 0, 6},
    {"", "$HOME/suckless/scripts/brightness_script.sh", 0, 5},
    {"", "$HOME/suckless/scripts/wifi_bars.sh", 5, 0},
    {"", "$HOME/suckless/scripts/battery_percentage.sh", 5, 0},
    {"", "$HOME/suckless/scripts/bat_script.sh", 0, 4},
    {"  ", "free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g", 30, 0},

    //{"",      "date '+%b %d (%a) %I:%M%p'", 5, 0},
    {"", "date '+%b %d (%a) %H:%M'", 5, 0},

};

// Sets delimiter between status commands. NULL character ('\0') means no
// delimiter.
static char *delim = " | ";

// Have dwmblocks automatically recompile and run when you edit this file in
// vim with the following line in your vimrc/init.vim:

// autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd
// ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid
// dwmblocks & }
