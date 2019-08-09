#!/bin/bash

UserName="ccxex29"
Exec="/opt/teamviewer/tv_bin/script/teamviewer"
#export DISPLAY=:0.0

if [[ $(sudo whoami) == "root" ]]; then
	systemctl start teamviewerd 
	
	$Exec 
	
	while ![[ $(pgrep teamviewer) = 0 ]]; do
		sudo echo -n 
		sleep 10s
	done

	systemctl stop teamviewerd"
fi