#!/bin/bash

if [[ $XDG_SESSION_TYPE == "x11" ]]; then
    # black bg (fallback)
    xsetroot -solid "#000000"

    #set random wallpaper
    feh --bg-tile --recursive --randomize ~/wallpaper
elif [[ $XDG_SESSION_TYPE == "wayland" ]]; then
    swaymsg "output * bg $(find ~/wallpaper -type f | shuf -n 1) tile #000000"
fi
