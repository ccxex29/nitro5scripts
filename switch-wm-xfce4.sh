#!/bin/bash

if [[ $(pgrep awesome) ]]; then
	kill -9 $(pgrep awesome) $(pgrep compton)
	xfwm4 --replace &
	notify-send -t 6000 "Window Manager Switch" "\nWindow Manager has been switched to XFWM4!"
else
	kill -9 $(pgrep xfwm4)
	awesome --replace &
	compton &
	notify-send -t 6000 "Window Manager Switch" "\nWindow Manager has been switched to AwesomeWM!"
fi

