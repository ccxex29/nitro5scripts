#!/bin/bash

currState=$(xfconf-query -c xfce4-notifyd -p /do-not-disturb)


if [[ $currState = 'true' ]]; then
	#echo -e "Do Not Disturb turned off"
	xfconf-query -c xfce4-notifyd -p /do-not-disturb -s false
	notify-send -t 5000 "Do Not Disturb Mode Off" "\nNotification OSD Enabled" -i "/home/ccxex29/.local/share/icons/moon_off.ico"
else
	#echo -e "Do Not Disturb turned on"
	notify-send -t 5000 "Do Not Disturb Mode On" "\nNotification OSD Disabled" -i "/home/ccxex29/.local/share/icons/moon.ico"
	xfconf-query -c xfce4-notifyd -p /do-not-disturb -s true
fi
