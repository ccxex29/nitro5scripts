#!/bin/bash

# Get app PID
appPid=$(pidof $1)

# Get dirty source-output from pacmd
pacmdList=$(pacmd list-source-outputs)


echo | awk -v appPid=$(echo $appPid) '
{
	i=1
	while (appPid {$i} != '' 
	for (i in appPid) {
		print i
	}
}
'
