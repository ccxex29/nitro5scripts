#!/bin/bash

currTheme=$(xfconf-query -c xsettings -p /Net/ThemeName)

if [[ "$1" = "adapta" ]]; then 
	if [[ $currTheme = "Adapta-Maia" ]]; then
		notify-send -t 5000 "Changing Theme to Dark Theme" "Setting to \"Adapta-Nokto-Maia\"" &
		xfconf-query -c xsettings -p /Net/ThemeName -s "Adapta-Nokto-Maia"
	elif [[ $currTheme = "Adapta-Nokto-Maia" ]]; then
		notify-send -t 5000 "Changing Theme to Light Theme" "Setting to \"Adapta-Maia\"" &
		xfconf-query -c xsettings -p /Net/ThemeName -s "Adapta-Maia"
	fi
elif [[ "$1" = "matcha" ]]; then
	if [[ $currTheme = "Matcha-dark-aliz" ]]; then
		notify-send -t 5000 "Changing Theme to Dark Theme" "Setting to \"Matcha-aliz\"" &
		xfconf-query -c xsettings -p /Net/ThemeName -s "Matcha-aliz"
	elif [[ $currTheme = "Matcha-aliz" ]]; then
		notify-send -t 5000 "Changing Theme to Light Theme" "Setting to \"Matcha-dark-aliz\"" &
		xfconf-query -c xsettings -p /Net/ThemeName -s "Matcha-dark-aliz"
	fi
else
	read -p "Unknown parameter"
fi
