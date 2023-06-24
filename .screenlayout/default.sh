#!/bin/sh
#
# default layout
#  _________ _________
# |         |         |
# |    1    |    2    |
# |_________|_________|
#

SESSION_TYPE="$(~/.scripts/get-session-type.sh)"

if [[ $SESSION_TYPE == "x11" ]]; then
    xrandr --output DisplayPort-0 --primary --mode 2560x1440 --rate 144 --pos 0x0 --rotate normal --output DisplayPort-1 --mode 2560x1440 --rate 144 --pos 2560x0 --rotate normal --output DisplayPort-2 --off --output HDMI-A-0 --off
    xrandr --output DisplayPort-0 --set TearFree on --output DisplayPort-1 --set TearFree on

elif [[ $SESSION_TYPE == "wayland" ]]; then
    swaymsg output DP-1 mode 2560x1440@144Hz pos 0 0
    swaymsg output DP-2 mode 2560x1440@144Hz pos 2560 0
    swaymsg output \* max_render_time off
fi
