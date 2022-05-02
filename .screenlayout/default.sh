#!/bin/sh
#
# default layout
#  _________
# |         |_______
# |    1    |   2   |
# |_________|_______|
#

SESSION_TYPE="$(~/.scripts/get-session-type.sh)"

if [[ $SESSION_TYPE == "x11" ]]; then
    xrandr --output DisplayPort-0 --off --output DisplayPort-1 --primary --mode 2560x1440 --rate 144 --pos 0x0 --rotate normal --output DisplayPort-2 --off --output HDMI-A-0 --mode 1920x1080 --pos 2560x360 --rotate normal
elif [[ $SESSION_TYPE == "wayland" ]]; then
    swaymsg output DP-2 mode 2560x1440@144Hz pos 0 0
    swaymsg output HDMI-A-1 mode 1920x1080 pos 2560 360
fi
