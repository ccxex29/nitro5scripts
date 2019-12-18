#!/bin/bash
timenow=$(date +Screenshot_%Y-%m-%d_%H-%M-%S.png)
location="$HOME/Pictures/Screenshots/$timenow"
xfce4-screenshooter -r -o cat > "$location"
timelater=$(date +Screenshot_%Y-%m-%d_%H-%M-%S.png)
location2="$HOME/Pictures/Screenshots/$timelater"

if [[ ! -s "$location" ]]; then 	# Case the result is blank file
	rm $location
elif [[ -e "$location" ]]; then	# Case the file is not deleted during the process
	mv $location $location2
fi
