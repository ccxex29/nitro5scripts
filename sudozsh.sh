#!/bin/bash

if [[ $1 = 'su' ]]; then
	sudo -s /usr/bin/zsh "${@:2}"
else
	sudo "$@"
fi
