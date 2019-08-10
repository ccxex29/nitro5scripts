#!/bin/bash

testValue=$(systemctl --user is-active gamemoded)

if [[ $testValue = 'active' ]]; then
	notify-send -t 10000 "Using GameMode for ATLauncher" "\nATLauncher will use several optimization calls by system" -i "/home/ccxex29/.local/share/icons/modpack.png"
	LD_PRELOAD=/usr/\$LIB/libgamemodeauto.so "$HOME/Other Games/ATLauncher/ATLauncher_64bit"
else
	"$HOME/Other Games/ATLauncher/ATLauncher_64bit"
fi
