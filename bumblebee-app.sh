#!/bin/bash

inputStr=$(zenity --entry --title="Bumblebee NVScript" --text="Enter App Exec:" --width=300)
if [[ ! (-z "$inputStr") ]]; then
	zenity --info --text="Running $inputStr with Discrete Graphics!" --width=250
	vblank_mode=0 primusrun "$inputStr"
fi
