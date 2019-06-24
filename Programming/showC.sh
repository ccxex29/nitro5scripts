#!/bin/bash

YELLOWCOLOR='\033[1;33m'
NOCOLOR='\033[0m'
CURRENT=`grep namafile config/config.cfg | cut -d '=' -f 2` # Needs to be set as working directory

xfce4-terminal -x bash -c "find /home/ccxex29/Programming/C -type f -name '*.c'; printf '\n${YELLOWCOLOR}Current File Name : $CURRENT\n\n${NOCOLOR}'; read -p 'Enter to Continue'"