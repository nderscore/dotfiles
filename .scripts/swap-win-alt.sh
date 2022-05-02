#!/bin/sh
#
# configures mac keyboard mode 
#
# swaps the positions of the alt/win keys
# 
# accepts arg of {ON/OFF/TOGGLE} to set swap state

ENABLED="$(setxkbmap -query | grep 'altwin:swap_alt_win' -c)"

ACTION=$1

if [ $ACTION == "TOGGLE" ]; then
	if [ $ENABLED == "0" ]; then
		ACTION=ON
	else
		ACTION=OFF
	fi
fi

if [ $ACTION == "ON" ]; then
	setxkbmap -option
	setxkbmap -option "apple:alupckeys,altwin:swap_alt_win"
	if [[ $XDG_SESSION_TYPE == "wayland" ]]; then
		swaymsg "input type:keyboard xkb_options \"apple:alupckeys,altwin:swap_alt_win\""
	fi
else
	setxkbmap -option
	setxkbmap -option "apple:alupckeys"
	if [[ $XDG_SESSION_TYPE == "wayland" ]]; then
		swaymsg "input type:keyboard xkb_options \"apple:alupckeys\""
	fi
fi

if [[ $XDG_SESSION_TYPE == "x11" ]]; then
	# reapply custom keymap modifications from .Xmodmap
	cat $HOME/.Xmodmap | xmodmap -
fi
