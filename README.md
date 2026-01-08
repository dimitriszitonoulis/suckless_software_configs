# My config for dwm, dmenu and dwmblocks

## Contents

In this repository are my configs for suckless apps dwm, dmenu and dwmblocks
as well as the original version of dwm (dwm-6.5) on which I built my config.
Check the [dwm site]() [dmenu]() for more info on dwm and dmenu
For more information about suckless apps check the official [suckless website](https://suckless.org/).

dwmblocks is a status bar for dwm.
The vesion I use is based on [Luke Smith's dwmblocks](https://github.com/LukeSmithxyz/dwmblocks)
however the clickable blocks do not work with dwm-6.5.
I modified the dwmblocks source code to work with dwm-6.5
(check the [README in dwmblocks directory](/dwmblocks/README.md)).

## Assumptions

- This guide assumes that you use arch linux.
Any linux distribution can work but the instructions
on package names and how to install said packages will be based on arch.
- No display manager is used. After the boot process the default login shell is shown.

## Requirements

Any of the following apps can be omitted by editing `dwm/config.h`

- kitty
- Xorg server, startx, xrandr
- firefox
- spotify-launcher
- Jetbrains mono nerd font
- playerctl
- flameshot
- picom
- bluetui
- btop
- brightnessctl
- wireplumber (for wpctl)
- My custom scripts for dwmblocks

The packages can be installed with the following command:

```bash
sudo pacman -Syu \
kitty \
xorg-server \
xorg-apps \
spotify-launcher \
firefox \
playerctl \
flameshot \
picom \
bluetui \
btop \
brightnessctl \
wireplumber
```

## How to build

### With my config

**Make sure that `kitty` is installed**.

The config of dwm contains the name of the terminal emulator to be run.
I chose `kitty`.

**ATTENTION**:
If the terminal emulator (`kitty`) is not installed then no
terminal can be launched => no packages can be installed => installation is unusable.

#### Install

Clone the repository with the command:

```bash
git clone https://github.com/dimitriszitonoulis/suckless_software_configs.git
```

#### Compile dmenu, dwm and dwmblocks from source

```bash
cd <path to repository directory>/dmenu
sudo make clean install

cd <path to repository directory>/dwm
sudo make clean install

cd <path to repository directory>/dwmblocks
sudo make clean install
```

#### Run on system start

Edit your shell's profile file to include the following.
I use zsh so I add the following to `.zprofile`

```bash
# to start display manager after user login
if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
  exec startx
fi
```

Edit `.xitinirc` to include dwm and dwmblocks

An example `.xinitrc`:

```bash
# kill existing instances of dwmblocks
pkill -x dwmblocks 2>/dev/null

# run dwm blocks in backround
dwmblocks &

# start dwm
exec dwm
```

You can copy my `.xinitrc` from my
[dotfiles](https://github.com/dimitriszitonoulis/.dotfiles) repository.

#### dwmblocks

dwmblocks uses some of my custom scripts. For more info check
the [README in dwmblocks directory](/dwmblocks/README.md).

### With the original

Do not forget to change terminal emulator to the one you have installed
or download st
