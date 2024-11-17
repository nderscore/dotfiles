#!/bin/sh
#
# move secondary monitor below primary monitor to avoid accidental loss of focus
# while gaming in full screen
#  _________
# |         |
# |    1    | (mouse can't move to second monitor except from bottom right corner)
# |_________|_________
#           |         |
#           |    2    |
#           |_________|
#

SESSION_TYPE="$(~/.scripts/get-session-type.sh)"

if [[ $SESSION_TYPE == "x11" ]]; then
    xrandr --output DisplayPort-0 --primary --mode 2560x1440 --rate 165 --pos 0x0 --rotate normal --output DisplayPort-1 --mode 2560x1440 --rate 60 --pos 2560x1440 --rotate normal --output DisplayPort-2 --off --output HDMI-A-0 --off
    xrandr --output DisplayPort-0 --set TearFree on --output DisplayPort-1 --set TearFree off
elif [[ $SESSION_TYPE == "wayland" ]]; then
    swaymsg output DP-1 mode 2560x1440@165Hz pos 0 0
    swaymsg output DP-2 mode 2560x1440@165Hz pos 2560 1440
   swaymsg output \* max_render_time off
fi
