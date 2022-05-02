#!/bin/bash

SESSION_TYPE="$(~/.scripts/get-session-type.sh)"

if [[ $SESSION_TYPE == "x11" ]]; then
    # black bg (fallback)
    xsetroot -solid "#000000"

    #set random wallpaper
    feh --bg-tile --recursive --randomize ~/wallpaper
elif [[ $SESSION_TYPE == "wayland" ]]; then
    if [[ -z $SWAYSOCK ]]; then
        export SWAYSOCK="$(cat ~/.swaying)"
    fi
    swaymsg "output * bg $(find ~/wallpaper -type f | shuf -n 1) tile #000000"
fi
