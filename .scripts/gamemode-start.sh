#!/bin/bash
#
# Script to run when gamemode is started

if [[ -f ~/.swaying ]]; then
    export SWAYSOCK="$(cat ~/.swaying)"
fi

DS4_ID="$(bluetoothctl paired-devices | grep -Po '[[:alnum:]]{2}(:[[:alnum:]]{2})+(?= DualShock4)')"
CONTROLLER_CONNECTED="$(bluetoothctl info $DS4_ID | grep -c 'Connected: yes')"

# enable screen & keyboard modifications only if game controller is not connected
if [ $CONTROLLER_CONNECTED == "0" ]; then
    # enable gaming screen layout
    ~/.screenlayout/gaming.sh

    # enable win/alt key swap
    ~/.scripts/swap-win-alt.sh ON
fi

# send notification
notify-send -u low "Game mode started."
