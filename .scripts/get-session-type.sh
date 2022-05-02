#!/bin/bash
#
# determine if in x11 or wayland

if [[ -n $XDG_SESSION_TYPE ]]; then
    echo $XDG_SESSION_TYPE
elif [[ -f $HOME/.swaying ]]; then
    echo "wayland"
elif [[ -f $HOME/.i3ing ]]; then
    echo "x11"
else
    echo "none"
fi
