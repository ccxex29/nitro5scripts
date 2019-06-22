#!/bin/bash

checkstate="$(cat /sys/devices/system/cpu/intel_pstate/no_turbo)"

if [[ $checkstate = '1' ]]; then
	status="$(cat /sys/class/power_supply/BAT1/status)"
	if [[ $status = 'Charging' ]]; then
	    charging="$(echo 0 | pkexec tee /sys/devices/system/cpu/intel_pstate/no_turbo)"
	    if [[ $charging = '0' ]]; then
		zenity --info --text="Turbo enabled successfully" --width=150
	    else
		zenity --error --text="Please check for Permission Error\n" --width=250
	    fi
	elif [[ $status = 'Discharging' ]]; then
	    zenity --error --text="Battery is currently not charging\nTLP settings prohibits Turbo while not on AC" --width=300 
	elif [[ $status = 'Full' ]] || [[ $status = 'Unknown' ]]; then
	    charged="$(echo 0 | pkexec tee /sys/devices/system/cpu/intel_pstate/no_turbo)"
		if [[ $charged != '0' ]]; then
			zenity --error --text="Please check for Permission Error\n" --width=250
		else
			zenity --info --text="Successfully applied" --width=150
		fi
	fi
elif [[ $checkstate = '0' ]]; then
	turnoff="$(echo 1 | pkexec tee /sys/devices/system/cpu/intel_pstate/no_turbo)"
	if [[ $turnoff = '1' ]]; then
		zenity --info --text="Turbo Boost is now Disabled" --width=200
	else
		zenity --error --text="Please check for Permission Error\n" --width=250
	fi
fi