#!/bin/sh
#
# move secondary monitor below primary monitor to avoid accidental loss of focus
# while gaming in full screen
#  _________
# |         |
# |    1    | (mouse can't move to second monitor except from bottom right corner)
# |_________|________
#           |   2   |
#           |_______|

xrandr --output DVI-D-0 --off --output HDMI-0 --mode 1920x1080 --pos 2560x1440 --rotate normal --output DP-0 --off --output DP-1 --off --output DP-2 --off --output DP-3 --off --output DP-4 --primary --mode 2560x1440 --rate 144 --pos 0x0 --rotate normal --output DP-5 --off
