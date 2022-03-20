#!/bin/bash
#
# Script to run when gamemode is stopped

# restore default screen layout
~/.screenlayout/default.sh

# restore win/alt key positions
~/.scripts/swap-win-alt.sh OFF

# send notification
notify-send -u low "Game mode stopped."
