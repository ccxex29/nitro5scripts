#!/bin/bash

currTheme=$(xfconf-query -c xsettings -p /Net/ThemeName)

if [[ $currTheme = "Adapta-Maia" ]]; then
	notify-send -t 5000 "Changing Theme to Dark Theme" "Setting to \"Adapta-Nokto-Maia\"" &
	xfconf-query -c xsettings -p /Net/ThemeName -s "Adapta-Nokto-Maia"
elif [[ $currTheme = "Adapta-Nokto-Maia" ]]; then
	notify-send -t 5000 "Changing Theme to Light Theme" "Setting to \"Adapta-Maia\"" &
	xfconf-query -c xsettings -p /Net/ThemeName -s "Adapta-Maia"
fi
