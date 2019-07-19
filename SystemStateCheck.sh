#!/bin/bash

CYANCOLOR='\033[1;36m'
YELLOWCOLOR='\033[1;33m'
GREENCOLOR='\033[1;32m'
REDCOLOR='\033[1;31m'
WHITECOLOR='\033[1;37m'
NOCOLOR='\033[0m'

# Extreme Profile Vars
scriptDir="/home/ccxex29/.scripts/"

stateBattery="config/extremebatterystate"
statePerformance="config/extremeperformancestate"
stateBalance="config/balancestate"

# Game Mode Var
gameMode=$(systemctl --user is-active gamemoded)

#Exec

##Performance Profile
printf "Your Performance Profile: "
if [[ -f "$scriptDir$stateBattery" ]]; then
	printf "Extreme Battery"
elif [[ -f "$scriptDir$statePerformance" ]]; then
	printf "Extreme Performance"
elif [[ -f "$scriptDir$stateBalance" ]]; then
	printf "Balanced Performance"
else
	printf "Custom Profile"
fi
printf "\n"

##Game Mode
printf "Game Mode: $gameMode\n"

printf "Use ZSWAP: $(cat /sys/module/zswap/parameters/enabled)\n"
if [[ $(cat /sys/module/zswap/parameters/enabled) = 'Y' ]]; then
	printf "ZSWAP Compressor: $(cat /sys/module/zswap/parameters/compressor)\n"
	echo -e "Max Pool: $(cat /sys/module/zswap/parameters/max_pool_percent) %"
	printf "ZPool: $(cat /sys/module/zswap/parameters/zpool)\n"
fi

##NoteBook FanControl
printf "NBFC (Notebook FanControl): \n"
nbfc status

