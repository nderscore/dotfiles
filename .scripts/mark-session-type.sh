#!/bin/bash
#
# failsafe option for get-session-type.sh
# see: .config/tiling/00-session

I3_MARKER="${HOME}/.i3ing"
SWAY_MARKER="${HOME}/.swaying"

rm $I3_MARKER
rm $SWAY_MARKER

if [[ $1 == "i3" ]]; then
    touch $I3_MARKER
elif [[ $1 == "sway" ]]; then
    echo $SWAYSOCK > $SWAY_MARKER
fi
