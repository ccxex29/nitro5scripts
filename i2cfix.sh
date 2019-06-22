#!/bin/bash
# Workaround for https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1784152
# Copy the script to /lib/systemd/system-sleep/reload-dell-touchpad.sh

SUSPEND_MODULES="i2c_hid"

case $1 in
    pre)
        for mod in $SUSPEND_MODULES; do
            rmmod $mod
        done
    ;;
    post)
        for mod in $SUSPEND_MODULES; do
            modprobe $mod
        done
    ;;
    reload)
        for mod in $SUSPEND_MODULES; do
	    rmmod $mod
	    modprobe $mod
	done
    ;;
esac
