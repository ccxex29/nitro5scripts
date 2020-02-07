#!/bin/bash

if [[ "$1" = "xfwm" ]]; then
	killall picom
	xfconf-query -c xfwm4 -p /general/use_compositing -s true
elif [[ "$1" = "picom" ]]; then
	xfconf-query -c xfwm4 -p /general/use_compositing -s false
	picom &
else
	echo -e "Unknown argument $1"
fi
