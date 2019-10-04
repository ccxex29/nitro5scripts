#!/bin/bash

toRemove="/opt/nbfc/Plugins/StagWare.Plugins.ECSysLinux.dll"

if [[ -e $toRemove ]]; then
	echo -e "Your NBFC needs fixing! This process requires superuser access!"
	if [[ $(sudo whoami) = 'root' ]]; then
		sudo rm /opt/nbfc/Plugins/StagWare.Plugins.ECSysLinux.dll
		sudo systemctl restart nbfc
		nbfc start -e
	else
		echo -e "You are not root! Program terminating.."
	fi
else
	if [[ $1 != '-quiet' ]]; then
		echo -e "NBFC seems to be fine and does not need fixing"
	fi
fi
