#!/bin/bash
#
# powers bluetooth on/off
#
# accepts arg of {ON/OFF/TOGGLE}

ENABLED="$(bluetoothctl show | grep 'Powered: yes' -c)"

ACTION=$1

if [ -z "$ACTION" ] || [ $ACTION == "TOGGLE" ]; then
	if [ $ENABLED == "0" ]; then
		ACTION=ON
	else
		ACTION=OFF
	fi
fi

if [ $ACTION == "ON" ]; then
    bluetoothctl power on
    notify-send -u low "Bluetooth powered on."
else
    bluetoothctl power off
    notify-send -u low "Bluetooth powered off."
fi
