#!/bin/bash
#
# Script to run when gamemode is started

if [[ -f ~/.swaying ]]; then
    export SWAYSOCK="$(cat ~/.swaying)"
fi

# enable gaming screen layout
~/.screenlayout/gaming.sh

# enable win/alt key swap
~/.scripts/swap-win-alt.sh ON

# send notification
notify-send -u low "Game mode started."
