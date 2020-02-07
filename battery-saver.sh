#!/bin/bash

state="/home/ccxex29/.scripts/config/state.tmp"

# Suspend app processes
process_firefox=$(pgrep firefox) 
process_tumbler=$(pgrep tumbler) 

# Suspend Bluetooth
process_bluetoothd=$(pgrep bluetoothd) 
process_bluemanapplet=$(pgrep blueman-applet)
process_obexd=$(pgrep obexd)


###############################################################


if [[ ! -e "${state}" ]]; then
	touch $state
	#echo -e "$process_firefox\n$process_tumbler\n$process_bluetoothd\n$process_obexd" >> $state
	
	# Suspend app processes
	kill -STOP $process_firefox
	kill -STOP $process_tumbler
	
	# Suspend Bluetooth
	kill -STOP $process_bluetoothd
	kill -STOP $process_bluemanapplet
	kill -STOP $process_obexd
	
	#Disable compositor
	xfconf-query -c xfwm4 -p /general/use_compositing -s false
else
	rm $state

	# Continue app processes
	kill -CONT $process_firefox
	kill -CONT $process_tumbler
	
	# Continue Bluetooth
	kill -CONT $process_bluetoothd
	kill -CONT $process_bluemanapplet
	kill -CONT $process_obexd
	
	#Enable compositor
	xfconf-query -c xfwm4 -p /general/use_compositing -s true
fi
