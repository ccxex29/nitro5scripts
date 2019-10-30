#!/bin/bash

echo -e "Detected NVIDIA GPU:"
lspci | grep "VGA" | grep "NVIDIA"

if [[ $(sudo whoami) = 'root' ]]; then
	# Initialization
	sudo modprobe acpi_call
	uInput=-1

	while ! [[ $uInput = 1 ]] && ! [[ $uInput = 2 ]] && ! [[ $uInput = 0 ]]
	do
		echo -e "Which do you want to do?"
		echo -e "1. Turn on NVIDIA GPU"
		echo -e "2. Turn off NVIDIA GPU"
		echo -e "0. Cancel and Exit"
		echo -e "\n"
		echo -e "Keep in mind that this is done by using acpi_call hence will require the installation of it first and may result in system hanging. Do NOT turn off the GPU while it is in use!!"
		read -p "Enter Your Input: " uInput
		clear
	done

	if [[ $uInput = 1 ]]; then
		echo '\_SB.PCI0.PEG0.PEGP._ON' | sudo tee /proc/acpi/call 2> /dev/null
	elif [[ $uInput = 2 ]]; then
		echo '\_SB.PCI0.PEG0.PEGP._OFF' | sudo tee /proc/acpi/call 2> /dev/null
		echo 1 | sudo tee /sys/bus/pci/devices/0000:01:00.0/remove 2> /dev/null
	fi

	echo 1 | sudo tee /sys/bus/pci/rescan 2> /dev/null
	sudo modprobe -r acpi_call
fi



