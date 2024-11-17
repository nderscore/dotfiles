#!/bin/bash

# TODO: swaywm?

LANG_EN="xkb:us::eng"
LANG_JP="mozc-jp"

if [ `ibus engine` = $LANG_EN ]; then
	ibus engine $LANG_JP
	notify-send -u low "こんにちは！"
else
	ibus engine $LANG_EN
	notify-send -u low "じゃあね！"
fi

if [[ $SESSION_TYPE == "x11" ]]; then
	# reapply custom keymap modifications from .Xmodmap
	cat $HOME/.Xmodmap | xmodmap -
fi