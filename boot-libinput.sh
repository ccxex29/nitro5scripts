#!/bin/bash

### Simple Touchpad Config ###
#xinput set-prop "ETPS/2 Elantech Touchpad" 304 1000
xinput set-prop "ETPS/2 Elantech Touchpad" "Synaptics Locked Drags" 1
#xinput set-prop "ETPS/2 Elantech Touchpad" "libinput Disable While Typing Enabled" 1
xinput set-prop "ETPS/2 Elantech Touchpad" "Synaptics Locked Drags Timeout" 1000
xinput set-prop "ETPS/2 Elantech Touchpad" "Synaptics Two-Finger Scrolling" 1 1
xinput set-prop "ETPS/2 Elantech Touchpad" "Synaptics Palm Detection" 1
#xinput set-prop "ETPS/2 Elantech Touchpad" 300 1 1

### Advanced Touchpad Config ###
xinput set-prop "ELAN0504:01 04F3:3091 Touchpad" "Synaptics Locked Drags" 1
xinput set-prop "ELAN0504:01 04F3:3091 Touchpad" "Synaptics Locked Drags Timeout" 1000
xinput set-prop "ELAN0504:01 04F3:3091 Touchpad" "Synaptics Two-Finger Scrolling" 1 1
xinput set-prop "ELAN0504:01 04F3:3091 Touchpad" "Synaptics Palm Detection" 1
xinput set-prop "ELAN0504:01 04F3:3091 Touchpad" "Device Accel Profile" 2
xinput set-prop "ELAN0504:01 04F3:3091 Touchpad" "Device Accel Velocity Scaling" 6.8
xinput set-prop "ELAN0504:01 04F3:3091 Touchpad" "Synaptics Tap Durations" 80 180 100
xinput set-prop "ELAN0504:01 04F3:3091 Touchpad" "Synaptics Finger" 10 15 0
#xinput set-prop "ELAN0504:01 04F3:3091 Touchpad" 