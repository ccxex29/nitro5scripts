#!/bin/bash

tries=3
success=false

function check_jack() {
	if [[ $(jack_control status | cut -f 3 -d ' ') = 'checked' ]]; then
		return true
	else
		return false
	fi
}

if [[ check_jack ]]; then
	echo "Already set"
	return
fi

for x in {1 .. 3}; do
	jack_control start
	if [[ check_jack ]]; then
		success=true
		break
	else
		jack_control stop
	fi
done

if [[ ! $success ]]; then
	echo "Failed after $tries tries!"
else
	pactl set-default-sink jack_out
	pactl set-default-source jack_in
fi
