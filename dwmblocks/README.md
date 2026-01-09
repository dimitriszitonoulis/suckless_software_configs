# dwmblocks

## Description

Modular status bar for dwm written in c.
This vesion is based on [Luke Smith's dwmblocks](https://github.com/LukeSmithxyz/dwmblocks).
The clickable blocks of that version does not work with dwm-6.5
so I modified the source code to make it work.

## Modifying blocks

The statusbar is made from text output from commandline programs.
Blocks are added and removed by editing the config.h header file.

## My build

### Source code modifications

Modified the `sighandler()` for dwm-6.5.
In this version dwm does not send `SIGUR1` signals to dwmblocks.
It sends `SIGRTMIN+n` signals.

### Custom scripts

dwmblocks uses my custom scripts which can be found in my
[scripts](https://github.com/dimitriszitonoulis/scripts.git) repository.

## Signaling changes

Most status bars constantly rerun every script every several seconds to update.
This is an option here, but a superior choice is giving your module a signal
that you can signal to it to update on a relevant event, rather than having it
rerun idly.

For example, if a program has the update signal 6
running `pkill -RTMIN+6 dwmblocks` will update it.

You can also run `kill -40 $(pidof dwmblocks)` which will have the same effect,
but is faster. Just add 34 to your typical signal number.

All modules must have different signal numbers.

## Clickable modules

This build allows you to build in additional actions into your
scripts in response to click events.
See the above linked scripts for examples of this using the `$BUTTON` variable.
The `$BUTTON` variable is exported by dwm.
Its value is set in the `buttons` array in `dwm/config.h`.

For example, pressing on the volume script block is equivalent to running:
`export BUTTON=1; ~/scripts/dwmblocks/volume_script.sh` in the terminal
which mutes volume.
