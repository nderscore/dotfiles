#!/bin/bash
#
# Script to run when gamemode is stopped

if [[ -f ~/.swaying ]]; then
    export SWAYSOCK="$(cat ~/.swaying)"
fi

# restore default screen layout
~/.screenlayout/default.sh

# restore win/alt key positions
~/.scripts/swap-win-alt.sh OFF

# send notification
notify-send -u low "Game mode stopped."
