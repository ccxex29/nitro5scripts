#!/bin/bash
CYANCOLOR='\033[1;36m'
YELLOWCOLOR='\033[1;33m'
GREENCOLOR='\033[1;32m'
REDCOLOR='\033[1;31m'
NOCOLOR='\033[0m'

stateBattery="config/extremebatterystate"
statePerformance="config/extremeperformancestate"
stateBalance="config/balancestate"

Performance=$(cpupower frequency-info | grep "hardware limits")
Performance=$(echo $Performance | cut -d ':' -f 2)
minPerformance=$(echo $Performance | cut -d '-' -f 1)
maxPerformance=$(echo $Performance | cut -d '-' -f 2)
minHertz=$(echo $minPerformance | cut -d ' ' -f 2)
maxHertz=$(echo $maxPerformance | cut -d ' ' -f 2)
minPerformance=$(echo $minPerformance | cut -d ' ' -f 1)
maxPerformance=$(echo $maxPerformance | cut -d ' ' -f 1)

#The plan is to save configuration file of current state and switch from 2400MHz (or 4000MHz)
#to 800MHz or vice versa

if [[ $minHertz = "GHz" ]]; then
	minPerformance=$(bc -l <<< "$minPerformance*1000")
	minHertz="MHz"
fi
if [[ $maxHertz = "GHz" ]]; then
	maxPerformance=$(bc -l <<< "$maxPerformance*1000")
	maxHertz="MHz"
fi

userPrompt='-1'

while [ $userPrompt = '-1' ]
do
	printf "Enter only one of these numbers: ${GREENCOLOR}0${NOCOLOR}, ${GREENCOLOR}1${NOCOLOR}, and ${GREENCOLOR}2\n1 means Switching to Extreme Battery Mode\n2 means Switching to Extreme Performance Mode\n0 means Switching to Balanced Performance Mode\n\n${YELLOWCOLOR}"
	read -p "Enter Your Input: " userPrompt
	#printf -v userPrompt '%d\n' $userPrompt 2>/dev/null
	printf "${NOCOLOR}"

	if [[ $userPrompt = '1' ]]; then
		if [[ ! -e "${stateBattery}" ]]; then
			sudo cpupower frequency-set --min $minPerformance$minHertz
			sudo cpupower frequency-set --max $minPerformance$minHertz
			#sudo intel-undervolt apply
			echo 'power' | sudo tee /sys/devices/system/cpu/cpufreq/policy*/energy_performance_preference
			#echo 'balance_power' | sudo tee /sys/devices/system/cpu/cpufreq/policy*/energy_performance_preference
			sudo pstate-frequency -S -m 0 -n 0
			if [[ $(cat /sys/devices/system/cpu/cpufreq/policy0/energy_performance_preference) = "power" ]]; then
				rm $statePerformance
				rm $stateBalance
				touch $stateBattery
				printf "\n\n${GREENCOLOR}	Extreme Battery Mode Enabled \n\n${NOCOLOR}"
			else
				printf "\n\n${REDCOLOR}ERROR APPLYING Extreme Battery Mode! Are You Root?\n\n${NOCOLOR}"
			fi
		else
			echo -e "\n\n\n${YELLOWCOLOR}Already set ${NOCOLOR}"
		fi
		read -p ''
		

	elif [[ $userPrompt = '2' ]]; then
		if [[ ! -e "${statePerformance}" ]]; then
			sudo cpupower frequency-set --min $maxPerformance$maxHertz
			sudo cpupower frequency-set --max $maxPerformance$maxHertz
			#sudo intel-undervolt apply
			echo 'balance_performance' | sudo tee /sys/devices/system/cpu/cpufreq/policy*/energy_performance_preference
			sudo pstate-frequency -S -m 100 -n 0
			if [[ $(cat /sys/devices/system/cpu/cpufreq/policy0/energy_performance_preference) = "balance_performance" ]]; then
				rm $stateBalance
				rm $stateBattery
				touch $statePerformance
				printf "\n\n${YELLOWCOLOR}	Extreme Performance Mode Enabled \n\n${NOCOLOR}"
			else
				printf "\n\n${REDCOLOR}ERROR APPLYING Extreme Performance Mode! Are You Root?\n\n${NOCOLOR}"
			fi
		else
			echo -e "\n\n\n${YELLOWCOLOR}Already set ${NOCOLOR}"
		fi
		read -p ''

	elif [[ $userPrompt = '0' ]]; then
		if [[ ! -e "${stateBalance}" ]]; then
			sudo cpupower frequency-set --min $minPerformance$minHertz
			sudo cpupower frequency-set --max $maxPerformance$maxHertz
			#sudo intel-undervolt apply
			#echo 'power' | sudo tee /sys/devices/system/cpu/cpufreq/policy*/energy_performance_preference
			echo 'balance_power' | sudo tee /sys/devices/system/cpu/cpufreq/policy*/energy_performance_preference
			sudo pstate-frequency -S -m 100 -n 0
			if [[ $(cat /sys/devices/system/cpu/cpufreq/policy0/energy_performance_preference) = "balance_performance" ]]; then
				rm $statePerformance
				rm $stateBattery
				touch $stateBalance
				printf "\n\n${CYANCOLOR}	Balanced Mode Enabled \n\n${NOCOLOR}"
			else
				printf "\n\n${REDCOLOR}ERROR APPLYING Extreme Performance Mode! Are You Root?\n\n${NOCOLOR}"
			fi
		else
			echo -e "\n\n\n${YELLOWCOLOR}Already set ${NOCOLOR}"
		fi
		read -p ''

	else
		echo $userPrompt
		userPrompt='-1'
		printf "${REDCOLOR}Unknown Input!${NOCOLOR}"
		read -p ''
		for i in {0..20}
		do
			echo -e ''
		done
	fi
done