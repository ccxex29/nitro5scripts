#!/bin/bash

if [[ $(command -v nvidia-xrun) ]]; then
	echo -e "nvidia-xrun found!\n"
	source nvidia-xrun
	printHelp
fi