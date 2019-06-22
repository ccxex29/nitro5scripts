#!/bin/bash
CONFIG="config/extremebatterystate"
#The plan is to save configuration file of current state and switch from 2400MHz (or 4000MHz)
#to 800MHz or vice versa

sudo cpupower frequency-set --min 800MHz
sudo cpupower frequency-set --max 800MHz
sudo intel-undervolt apply
echo 'power' | sudo tee /sys/devices/system/cpu/cpufreq/policy*/energy_performance_preference
echo 'balance_power' | sudo tee /sys/devices/system/cpu/cpufreq/policy*/energy_performance_preference