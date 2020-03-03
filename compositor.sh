#!/bin/bash

if [[ "$1" = "xfwm" ]]; then
	killall picom
	xfwm4 --replace compositor=on
elif [[ "$1" = "picom" ]]; then
	xfwm4 --replace compositor=off
	picom &
elif [[ "$1" = "" ]]; then
	if [[ $(pgrep picom) = "" ]]; then
		notify-send -t 10000 "Switching Compositor" "Using Compositor picom\nWARNING! No desktop zoom available." &
		xfconf-query -c xfwm4 -p /general/use_compositing -s false
		xfwm4 --replace compositor=off &
		picom &
	else
		notify-send -t 10000 "Switching Compositor" "Using Compositor xfwm4" &
		killall picom
		xfwm4 --replace compositor=on &
		xfconf-query -c xfwm4 -p /general/use_compositing -s true
	fi
else
	echo -e "Unknown argument $1"
fi
