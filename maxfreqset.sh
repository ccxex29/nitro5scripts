#!/bin/bash

# RTC Interrupt
echo 2048 > /sys/class/rtc/rtc0/max_user_freq
echo 2048 > /proc/sys/dev/hpet/max-user-freq

# PCI Latency Timer
setpci -v -s 00:1f.3 latency_timer=ff
