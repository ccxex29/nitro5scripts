#!/bin/bash

appSinkName="ApplicationVirtualSink"
bridgeSinkName="VirtualBridgeSink"
realSourceName="jack_in"
realSinkName="jack_out"
mergedSourceName="ConferenceVirtualSource"


# Add Virtual Sinks 
pactl load-module module-null-sink sink_name="$appSinkName" sink_properties=device.description="$appSinkName"
pactl load-module module-null-sink sink_name="$bridgeSinkName" sink_properties=device.description="$bridgeSinkName"

# Connect Sinks with Output and Input
pactl load-module module-loopback latency_msec=1 source="$appSinkName.monitor" sink="$realSinkName"
pactl load-module module-loopback latency_msec=1 source="$appSinkName.monitor" sink="$bridgeSinkName"
pactl load-module module-loopback latency_msec=1 source="$realSourceName" sink="$bridgeSinkName"

# Spoof Virtual Sink Monitor into Real Source
pactl load-module module-remap-source master="$bridgeSinkName.monitor" source_name="$mergedSourceName" source_properties=device.description="$mergedSourceName"
