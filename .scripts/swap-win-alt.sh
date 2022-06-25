#!/bin/sh
#
# configures mac keyboard mode 
#
# swaps the positions of the alt/win keys
# 
# accepts arg of {ON/OFF/TOGGLE} to set swap state

SESSION_TYPE="$(~/.scripts/get-session-type.sh)"

ENABLED="$(setxkbmap -query | grep 'altwin:swap_alt_win' -c)"

ACTION=$1

if [ -z "$ACTION" ] || [ $ACTION == "TOGGLE" ]; then
	if [ $ENABLED == "0" ]; then
		ACTION=ON
	else
		ACTION=OFF
	fi
fi

if [ $ACTION == "ON" ]; then
	setxkbmap -option
	setxkbmap -option "apple:alupckeys,altwin:swap_alt_win"
	if [[ $SESSION_TYPE == "wayland" ]]; then
		swaymsg "input type:keyboard xkb_options \"apple:alupckeys,altwin:swap_alt_win\""
	fi
	notify-send -u low "Alt-win swapped."
else
	setxkbmap -option
	setxkbmap -option "apple:alupckeys"
	if [[ $SESSION_TYPE == "wayland" ]]; then
		swaymsg "input type:keyboard xkb_options \"apple:alupckeys\""
	fi
	notify-send -u low "Alt-win unswapped."
fi

if [[ $SESSION_TYPE == "x11" ]]; then
	# reapply custom keymap modifications from .Xmodmap
	cat $HOME/.Xmodmap | xmodmap -
fi
