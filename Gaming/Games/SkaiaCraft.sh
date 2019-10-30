#!/bin/bash

testValue=$(systemctl --user is-active gamemoded)
gameName="SkaiaCraft"
gameDir="$HOME/Other Games/SkaiaLauncherMC/SkaiaCraft Launcher v3.0.jar"

if [[ $testValue = 'active' ]]; then
	notify-send -t 10000 "Using GameMode for $gameName" "\n$gameName will use several optimization calls by system" -i "/home/ccxex29/.local/share/icons/vanilla.png"
	LD_PRELOAD=/usr/\$LIB/libgamemodeauto.so java -jar "$gameDir"
else
	java -jar "$gameDir"
fi	
	
