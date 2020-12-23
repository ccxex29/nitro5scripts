#!/bin/bash

appSinkName="ApplicationVirtualSink"
bridgeSinkName="VirtualBridgeSink"
realSourceName="jack_in"
realSinkName="jack_out"
mergedSourceName="ConferenceVirtualSource"

declare -a moduleNumbers=()

# Add Virtual Sinks 
moduleNumbers+=($(pactl load-module module-null-sink sink_name="$appSinkName" sink_properties=device.description="$appSinkName"))
moduleNumbers+=($(pactl load-module module-null-sink sink_name="$bridgeSinkName" sink_properties=device.description="$bridgeSinkName"))

# Connect Sinks with Output and Input
moduleNumbers+=($(pactl load-module module-loopback latency_msec=1 source="$appSinkName.monitor" sink="$realSinkName"))
moduleNumbers+=($(pactl load-module module-loopback latency_msec=1 source="$appSinkName.monitor" sink="$bridgeSinkName"))
moduleNumbers+=($(pactl load-module module-loopback latency_msec=1 source="$realSourceName" sink="$bridgeSinkName"))

# Spoof Virtual Sink Monitor into Real Source
moduleNumbers+=($(pactl load-module module-remap-source master="$bridgeSinkName.monitor" source_name="$mergedSourceName" source_properties=device.description="$mergedSourceName"))

# Just in case of script failure, output array!
indexCount=${#moduleNumbers[@]}
maxIndex=$((${indexCount} - 1))
echo "Max: ${moduleNumbers[$maxIndex]}"

printf "Module numbers: "
printf "("
for x in ${moduleNumbers[@]}
do
    printf $x
    [[ $x != ${moduleNumbers[$maxIndex]} ]] && printf " "
done
printf ")"
printf "\n"

# Wait For User Input
uinp=''
while [[ $uinp != "unload" ]]
do
    echo "INSERT \"unload\" IF YOU REALLY WANT TO UNLOAD"
    read -p "> " uinp 
done

# Loop through the modules to unload each one of them
unloadInp=''
while [[ $unloadInp != "y" && $unloadInp != "n" ]]
do
    read -p "Unload all modules? (Y/n)" unloadInp
    unloadInp=$(echo $unloadInp | tr '[:upper:]' '[:lower:]')
    [[ $unloadInp == "" ]] && unloadInp="y"
done

for ((i=$maxIndex; i>=0; i--))
do
    iNumber=${moduleNumbers[$i]}
    __input=""
    if [[ $unloadInp == 'n' ]]; then
        while [[ $__input != "y" && $__input != "n" ]]
	do
		read -p "Unloading $iNumber remove? (Y/n) " __input
            __input=$(echo $__input | tr '[:upper:]' '[:lower:]')
            [[ $__input == '' ]] && __input="y"
            [[ $__input == 'y' ]] && pactl unload-module $iNumber
	    [[ $__input == 'n' ]] && echo "Your call!"
        done
    else
	pactl unload-module $iNumber
    fi
done

