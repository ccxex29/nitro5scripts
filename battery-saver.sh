#!/bin/bash
process_firefox=$(pgrep firefox)
process_tumbler=$(pgrep tumbler)

kill -STOP $process_firefox
kill -STOP $process_tumbler

# Disable Bluetooth
process_bluetoothd=$(pgrep bluetoothd)
process_bluemanapplet=$(pgrep blueman-applet)
process_obexd=$(pgrep obexd)

kill -STOP $process_bluetoothd
kill -STOP $process_bluemanapplet
kill -STOP $process_obexd

#Disable compositor
xfwm4 --replace --compositor=off

touch battery-saver.temp

zenity --info --text="Press to resume process" --width=150

kill -CONT $process_firefox
kill -CONT $process_tumbler

kill -CONT $process_bluetoothd
kill -CONT $process_bluemanapplet
kill -CONT $process_obexd

#Enable compositor
xfwm4 --replace --compositor=on

rm battery-saver.temp
