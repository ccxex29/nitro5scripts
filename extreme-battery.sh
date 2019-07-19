#!/bin/bash
BLUECOLOR='\033[1;38;5;27m'
CYANCOLOR='\033[1;36m'
YELLOWCOLOR='\033[1;33m'
ORANGECOLOR='\033[1;38;5;214m'
REDCOLOR='\033[1;31m'
PINKCOLOR='\033[1;38;5;207m'
GREENCOLOR='\033[1;32m'
WHITECOLOR='\033[1;37m'
NOCOLOR='\033[0m'

scriptDir="/home/ccxex29/.scripts/"

stateBattery="config/extremebatterystate"
stateBatteryCasual="config/batterystate"
statePerformance="config/extremeperformancestate"
stateBalance="config/balancestate"
stateGaming="config/gamingstate"

Performance=$(cpupower frequency-info | grep "hardware limits")
Performance=$(echo $Performance | cut -d ':' -f 2)
minPerformance=$(echo $Performance | cut -d '-' -f 1)
maxPerformance=$(echo $Performance | cut -d '-' -f 2)
minHertz=$(echo $minPerformance | cut -d ' ' -f 2)
maxHertz=$(echo $maxPerformance | cut -d ' ' -f 2)
minPerformance=$(echo $minPerformance | cut -d ' ' -f 1)
maxPerformance=$(echo $maxPerformance | cut -d ' ' -f 1)



if [[ -f "$scriptDir$stateBattery" ]]; then
	currState=1
elif [[ -f "$scriptDir$statePerformance" ]]; then
	currState=2
elif [[ -f "$scriptDir$stateGaming" ]]; then
	currState=4
elif [[ -f "$scriptDir$stateBatteryCasual" ]]; then
	currState=5
elif [[ -f "$scriptDir$stateBalance" ]]; then
	currState=0
else
	currState=3
fi

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
	printf "\n\nYour Current Profile is "
	
	if [[ $currState = 0 ]]; then
		printf "${CYANCOLOR}Balanced Power${NOCOLOR}"
	elif [[ $currState = 1 ]]; then
		printf "${GREENCOLOR}Extreme Battery${NOCOLOR}"
	elif [[ $currState = 2 ]]; then
		printf "${YELLOWCOLOR}Extreme Performance${NOCOLOR}"
	elif [[ $currState = 4 ]]; then
		printf "${REDCOLOR}G${GREENCOLOR}A${BLUECOLOR}M${ORANGECOLOR}I${PINKCOLOR}N${CYANCOLOR}G${NOCOLOR}"
	elif [[ $currState = 5 ]]; then
		printf "${GREENCOLOR}Battery ECO${NOCOLOR}"
	else
		printf "${WHITECOLOR}Custom Configuration${NOCOLOR}"
	fi
	
	### MENU PERFORMANCE PROFILE SELECT ###
	printf "\n\nEnter only one of these numbers: ${GREENCOLOR}0${NOCOLOR}, ${GREENCOLOR}1${NOCOLOR}, and ${GREENCOLOR}2\n"
	printf "1 means Switching to Extreme Battery Mode\n"
	printf "2 means Switching to Battery ECO Mode\n"
	printf "3 means Switching to Extreme Performance Mode\n"
	printf "0 means Switching to Balanced Performance Mode\n\n"
	printf "${ORANGECOLOR}420 means Switching to Extreme Gaming Profile\n(It is always advised to use Balanced/Performance Profile)\n\n\n${YELLOWCOLOR}"
	read -p "Enter Your Input: " userPrompt
	#printf -v userPrompt '%d\n' $userPrompt 2>/dev/null
	printf "${NOCOLOR}"


	### BATTERY PROFILE ###
	if [[ $userPrompt = '1' ]] || [[ $userPrompt = '2' ]]; then
		if { [[ ! -e "${stateBattery}" ]] && [[ $userPrompt = '1' ]]; } || { [[ ! -e "${stateBatteryCasual}" ]] && [[ $userPrompt = "2" ]]; }; then
			if [[ $(sudo whoami) = 'root' ]]; then
				sudo cpupower frequency-set --min $minPerformance$minHertz
				sudo cpupower frequency-set --max $minPerformance$minHertz
				#sudo intel-undervolt apply
				echo 'power' | sudo tee /sys/devices/system/cpu/cpufreq/policy*/energy_performance_preference
				echo 'powersave' | sudo tee /sys/devices/system/cpu/cpufreq/policy*/scaling_governor
				#echo 'balance_power' | sudo tee /sys/devices/system/cpu/cpufreq/policy*/energy_performance_preference
				sudo pstate-frequency -S -m 0 -n 0
				rm $statePerformance 2> /dev/null
				rm $stateBalance 2> /dev/null
				rm $stateGaming 2> /dev/null
				
				## For Extreme Battery
				if [[ $userPrompt = '1' ]]; then
					nbfc set -f 0 -s 10
					nbfc set -f 1 -s 10
					rm $stateBatteryCasual 2> /dev/null
					touch $stateBattery
					printf "\n\n${GREENCOLOR}	Extreme Battery Mode Enabled \n\n${NOCOLOR}"
				## For Battery ECO
				else
					if [[ -e "${stateBattery}" ]] || [[ -e "${stateGaming}" ]]; then
						nbfc set -f 0 -a
						nbfc set -f 1 -a
					fi
					rm $stateBattery 2> /dev/null
					touch $stateBatteryCasual
					printf "\n\n${GREENCOLOR}	Battery ECO Mode Enabled \n\n${NOCOLOR}"
				fi
				
			else
				printf "\n\n${REDCOLOR}ERROR APPLYING Battery Mode! Are You Root?\n\n${NOCOLOR}"
			fi
		else
			echo -e "\n\n\n${YELLOWCOLOR}Already set ${NOCOLOR}"
		fi
		read -p ''
		

	### PERFORMANCE PROFILE ###
	elif [[ $userPrompt = '3' ]] || [[ $userPrompt = '420' ]]; then
		if { [[ ! -e "${statePerformance}" ]] && [[ $userPrompt = '3' ]]; } || { [[ ! -e "${stateGaming}" ]] && [[ $userPrompt = '420' ]]; }; then
			# Prevents multiple sudo
			if [[ $(sudo whoami) = 'root' ]]; then
				sudo cpupower frequency-set --min $maxPerformance$maxHertz
				sudo cpupower frequency-set --max $maxPerformance$maxHertz
				echo 'performance' | sudo tee /sys/devices/system/cpu/cpufreq/policy*/scaling_governor
				#sudo intel-undervolt apply
				sudo pstate-frequency -S -m 100 -n 0
				rm $stateBalance 2> /dev/null
				rm $stateBattery 2> /dev/null
				rm $stateBatteryCasual 2> /dev/null
				
				## For Performance
				if [[ $userPrompt = '3' ]]; then
					echo 'balance_performance' | sudo tee /sys/devices/system/cpu/cpufreq/policy*/energy_performance_preference
					if [[ -e "${stateBattery}" ]] || [[ -e "${stateGaming}" ]]; then
						nbfc set -f 0 -a
						nbfc set -f 1 -a
					fi
					rm $stateGaming 2> /dev/null
					touch $statePerformance
					printf "\n\n${YELLOWCOLOR}	Extreme Performance Mode Enabled \n\n${NOCOLOR}"
				## For Gaming
				else
					echo 'performance' | sudo tee /sys/devices/system/cpu/cpufreq/policy*/energy_performance_preference
					nbfc set -f 0 -s 100
					nbfc set -f 1 -s 100
					rm $statePerformance 2> /dev/null
					touch $stateGaming
					printf "\n\n${PINKCOLOR}	Extreme Gaming Mode Enabled \n\n${NOCOLOR}"	
				fi
			else
				printf "\n\n${REDCOLOR}ERROR APPLYING "
				if [[ $userPrompt = '3' ]]; then
					printf "Extreme Performance"
				else
					printf "Gaming"
				fi
				printf " Mode! Are You Root?\n\n${NOCOLOR}"
			fi
		else
			echo -e "\n\n\n${YELLOWCOLOR}Already set ${NOCOLOR}"
		fi
		read -p ''


	### BALANCE PROFILE ###
	elif [[ $userPrompt = '0' ]]; then
		if [[ ! -e "${stateBalance}" ]]; then
			if [[ $(sudo whoami) = 'root' ]]; then
				sudo cpupower frequency-set --min $minPerformance$minHertz
				sudo cpupower frequency-set --max $maxPerformance$maxHertz
				#sudo intel-undervolt apply
				#echo 'power' | sudo tee /sys/devices/system/cpu/cpufreq/policy*/energy_performance_preference
				echo 'balance_power' | sudo tee /sys/devices/system/cpu/cpufreq/policy*/energy_performance_preference
				echo 'powersave' | sudo tee /sys/devices/system/cpu/cpufreq/policy*/scaling_governor
				sudo pstate-frequency -S -m 100 -n 0
				if [[ -e "${stateBattery}" ]] || [[ -e "${stateGaming}" ]]; then
					nbfc set -f 0 -a
					nbfc set -f 1 -a
				fi
				####### Actions without root #######
				rm $statePerformance 2> /dev/null
				rm $stateBattery 2> /dev/null
				rm $stateBatteryCasual 2> /dev/null
				rm $stateGaming 2> /dev/null
				touch $stateBalance
				printf "\n\n${CYANCOLOR}	Balanced Mode Enabled \n\n${NOCOLOR}"
				####################################
			else
				printf "\n\n${REDCOLOR}ERROR APPLYING Balance Mode! Are You Root?\n\n${NOCOLOR}"
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