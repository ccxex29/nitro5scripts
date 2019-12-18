#!/bin/bash

## Sudoers must whitelist light

## Dependency: light or light-git
## Dependency: https://github.com/vlevit/notify-send.sh (no longer needed)
## Dependency: https://github.com/phuhl/notify-send.py

if [[ ! -e config/NID_Backlight ]]; then ## Create State File
	touch config/NID_Backlight
	echo 0 > config/NID_Backlight
fi

CURRENT_BACKLIGHT=$(light)
ID=$(cat config/NID_Backlight)


if [[ $1 = 'up' ]]; then
	if [[ $2 = '' ]]; then
		sudo light -A 1
	else
		sudo light -A "$2"
	fi
elif [[ $1 = 'down' ]]; then
	if [[ $2 = '' ]]; then
		sudo light -U 1
	else
		sudo light -U "$2"
	fi
fi

CHANGED_BACKLIGHT=$(light)
DELTA_BACKLIGHT=$(echo "$CHANGED_BACKLIGHT-$CURRENT_BACKLIGHT" | bc -l)

## Debugging ##

WRITTEN_BACKLIGHT=$(echo -e "$DELTA_BACKLIGHT" | awk '{printf "%.2f\n", $0}')

if [[ $DELTA_BACKLIGHT = 0 ]]; then
	ID=$(/home/ccxex29/Documents/GitSources/notify-send.sh/notify-send.sh -t 10000 -p "Screen Brightness Unchanged\!" "Value is $CHANGED_BACKLIGHT")
else
	#echo changed "$DELTA_BACKLIGHT"
	ID=$(/home/ccxex29/Documents/GitSources/notify-send.sh/notify-send.sh -t 10000 -p "Screen Brightness Changed\!" "Value changed by $WRITTEN_BACKLIGHT to $CHANGED_BACKLIGHT")
fi



## Change Last ID ##
sed -i "1s/.*/$ID/" config/NID_Backlight
