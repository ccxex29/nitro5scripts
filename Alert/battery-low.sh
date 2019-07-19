#!/bin/bash
BAT_PERCENTAGE=$(cat /sys/class/power_supply/BAT1/capacity)
BAT_CHARGE=$(cat /sys/class/power_supply/BAT1/charge_now)

notify-send -t 30000 "Low Battery Warning" "\nYour Battery only have few minutes left ($BAT_PERCENTAGE%). Now is the right time for plugging in to the AC Power. Waiting 1 minutes before suspending automatically." -i "/usr/share/icons/Papirus-Dark/48x48/devices/battery.svg" & 
sleep 1m
wait

BAT_CHARGE2=$(cat /sys/class/power_supply/BAT1/capacity)
BAT_PERCENTAGE2=$(cat /sys/class/power_supply/BAT1/capacity)
if [[ $(cat /sys/class/power_supply/BAT1/status) = "Discharging" ]] && [[ $BAT_CHARGE2 -le $BAT_CHARGE ]]; then
	zenity --info --text="Battery is low and about to die ($BAT_PERCENTAGE2%). Plug in your charger now!" --width=150 &
	systemctl suspend
else
	notify-send -t 5000 "Suspend Cancelled" -i "/usr/share/icons/Papirus-Dark/48x48/devices/battery.svg"
fi
