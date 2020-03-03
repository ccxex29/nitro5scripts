#!/bin/bash

uInput=-1

if [[ $(pgrep awesome) ]]; then
	read -p "Are you sure you want to switch to XFWM4? (Y/n)" uInput
	uInput=$(echo "$uInput" | awk '{print tolower($0)}')
	if [[ $uInput = '' ]] || [[ $uInput = 'y' ]] || [[ $uInput = 'yes' ]]; then
		kill -9 $(pgrep awesome) $(pgrep compton)
		xfwm4 --replace --display=:0 &
		xfce4-panel &
		notify-send -t 6000 "Window Manager Switch" "\nWindow Manager has been switched to XFWM4!"
	fi
else
	read -p "Are you sure you want to switch to AwesomeWM? (Y/n)" uInput
	uInput=$(echo "$uInput" | awk '{print tolower($0)}')
	if [[ $uInput = '' ]] || [[ $uInput = 'y' ]] || [[ $uInput = 'yes' ]]; then
		kill -9 $(pgrep xfwm4)
		awesome --replace &
		compton &
		killall xfce4-panel &	
		notify-send -t 6000 "Window Manager Switch" "\nWindow Manager has been switched to AwesomeWM!"
	fi
fi

