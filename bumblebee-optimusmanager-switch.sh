#!/bin/bash

GREENCOLOR='\033[1;32m'
REDCOLOR='\033[1;31m'
NOCOLOR='\033[0m'

bbState=$(systemctl is-enabled bumblebeed)
#omState=$(systemctl is-enabled optimus-manager)

echo -e "${REDCOLOR}MAKE SURE YOU HAVE SAVED ALL OF YOUR WORK BEFORE CONTINUING!!${NOCOLOR}"
read -p ''

if [[ $(sudo whoami) = 'root' ]];then
if [[ $bbState = "enabled" ]];then
		read -p "Are you sure you want to switch to Optimus Manager solution (Y/n) ? " input
		input=$(echo "$input" | awk '{print tolower($0)}')
		if [[ $input = 'y' ]] || [[ $input = 'yes' ]] || [[ $input = '' ]];then
			echo "Disabling bumblebeed..."
			sudo systemctl disable bumblebeed.service
			echo "Renaming nvidia-xorg.conf"
			sudo mv /etc/X11/nvidia-xorg.conf /etc/X11/nvidia-xorg.conf.bak
			echo "Renaming intel.conf"
			sudo mv /etc/X11/mhwd.d/intel.conf /etc/X11/mhwd.d/intel.conf.bak
			echo "Enabling optimus-manager..."
			sudo systemctl enable optimus-manager.service
		fi
	else
		read -p "Are you sure you want to switch to Bumblebee and Nvidia-xrun solution (Y/n) ? " input
		input=$(echo "$input" | awk '{print tolower($0)}')
		if [[ $input = 'y' ]] || [[ $input = 'yes' ]] || [[ $input = '' ]];then
			echo "Disabling optimus-manager..."
			sudo systemctl disable optimus-manager.service
			echo "Enabling bumblebeed..."
			sudo systemctl enable bumblebeed.service
			echo "Renaming nvidia-xorg.conf.bak"
			sudo mv /etc/X11/nvidia-xorg.conf.bak /etc/X11/nvidia-xorg.conf
			echo "Renaming intel.conf.bak"
			sudo mv /etc/X11/mhwd.d/intel.conf.bak /etc/X11/mhwd.d/intel.conf
			echo "Cleaning autogenerated Optimus Manager configurations..."
			sudo optimus-manager --cleanup
		fi
	fi
	read -p "Done! Reboot now (Y/n) ? " rebootnow
	rebootnow=$(echo "$rebootnow" | awk '{printf tolower($0)}')
	if [[ $rebootnow = 'y' ]] || [[ $rebootnow = 'yes' ]] || [[ $rebootnow = '' ]]; then
		reboot
	fi
else
	echo "Authorization failed. Are you root?"
	read -p ''	
fi
