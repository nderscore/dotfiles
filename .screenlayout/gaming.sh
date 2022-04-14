#!/bin/sh
#
# move secondary monitor below primary monitor to avoid accidental loss of focus
# while gaming in full screen
#  _________
# |         |
# |    1    | (mouse can't move to second monitor except from bottom right corner)
# |_________|_______
#           |   2   |
#           |_______|
#

xrandr --output DisplayPort-0 --off --output DisplayPort-1 --primary --mode 2560x1440 --rate 144 --pos 0x0 --rotate normal --output DisplayPort-2 --off --output HDMI-A-0 --mode 1920x1080 --pos 2560x1440 --rotate normal
