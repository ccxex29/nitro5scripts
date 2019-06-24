#!/bin/bash

testValue=$(systemctl --user is-active gamemoded)
programName="${1:50}"
programName=$(echo "$programName" | cut -d '/' -f 1)
if [[ $programName = "Left 4 Dead 2" ]]; then
	notifyIcon="/usr/share/icons/Papirus-Dark/64x64/apps/l4d2.svg"
else
	notifyIcon="/usr/share/icons/Papirus-Dark/64x64/apps/steam.svg"
fi
#xfce4-terminal -x bash -c "echo $1; read -p ''"
#xfce4-terminal -x bash -c "echo $programName; read -p ''"

if [[ $testValue = 'active' ]]; then 
	notify-send -t 10000 "Using GameMode for $programName" "\n$programName will use several optimization calls by system" -i "$notifyIcon"
	LD_PRELOAD=:/usr/\$LIB/libgamemodeauto.so "${1}"
else
	"${1}"
fi