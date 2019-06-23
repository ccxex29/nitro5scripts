#!/bin/bash

testValue=$(systemctl --user is-active gamemoded)

if [[ $testValue = 'active' ]]; then
	notify-send -t 10000 "Using GameMode for SkaiaCraft" "\nSkaiaCraft will use several optimization calls by system" -i "/home/ccxex29/.local/share/icons/vanilla.png"
	LD_PRELOAD=/usr/\$LIB/libgamemodeauto.so java -jar "/home/ccxex29/Other Games/SkaiaLauncherMC/SkaiaCraft Launcher v2.0.jar"
else
	java -jar "/home/ccxex29/Other Games/SkaiaLauncherMC/SkaiaCraft Launcher v2.0.jar"
fi	
	