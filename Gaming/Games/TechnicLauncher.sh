#!/bin/bash

testValue=$(systemctl --user is-active gamemoded)
gameName="Technic Launcher"
gameDir="$HOME/Other Games/TechnicLauncher/Technic_Launcher_64bit"

if [[ $testValue = 'active' ]]; then
	notify-send -t 10000 "Using GameMode for $gameName" "\n$gameName will use several optimization calls by system" -i "/home/ccxex29/.local/share/icons/modpack.png"
	LD_PRELOAD=/usr/\$LIB/libgamemodeauto.so "$gameDir"
else
	"$gameDir"
fi
