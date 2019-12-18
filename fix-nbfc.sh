#!/bin/bash

toRemove="/opt/nbfc/Plugins/StagWare.Plugins.ECSysLinux.dll"

if [[ -e $toRemove ]]; then
	echo -e "Your NBFC needs fixing! This process requires superuser access!"
	if [[ $(sudo whoami) = 'root' ]]; then
		sudo rm /opt/nbfc/Plugins/StagWare.Plugins.ECSysLinux.dll
		sudo systemctl restart nbfc
		if [[ $(nbfc start -e) = 'Connection Refused' ]]; then # May get connection refused. Workaround is to restart the nbfc as non-daemon
			sudo systemctl start nbfc
			nbfc start
		fi
	else
		echo -e "You are not root! Program terminating.."
	fi
else
	if [[ $1 != '-quiet' ]]; then
		echo -e "NBFC seems to be fine and does not need fixing"
	fi
fi
