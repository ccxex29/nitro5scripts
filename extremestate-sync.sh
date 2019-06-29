#!/bin/bash

stateBattery="config/extremebatterystate"
statePerformance="config/extremeperformancestate"
stateBalance="config/balancestate"

if [[ $(cat /sys/devices/system/cpu/cpufreq/policy0/energy_performance_preference) = "balance_performance" ]]; then
	echo "[Sync] Extreme Performance Mode"
	rm $stateBattery
	rm $stateBalance
	touch $statePerformance
elif [[ $(cat /sys/devices/system/cpu/cpufreq/policy0/energy_performance_preference) = "balance_power" ]]; then
	echo "[Sync] Balanced Mode"
	rm $statePerformance
	rm $stateBattery
	touch $stateBalance
elif [[ $(cat /sys/devices/system/cpu/cpufreq/policy0/energy_performance_preference) = "power" ]]; then
	echo "[Sync] Extreme Battery Mode"
	rm $statePerformance
	rm $stateBalance
	touch $stateBattery
fi