#!/bin/bash

#################
# JACK Specific #
#################

########
# Ensuring JACK is not yet started
########
jack_control start

# ENGINE #
# Set Realtime
jack_control eps realtime True
# Set Name
#jack_control eps name ccxex29

# DRIVER #
# Set ALSA Driver
jack_control ds alsa
# Device Select
jack_control dps device hw:PCH,0
jack_control dps capture hw:PCH,0
jack_control dps playback hw:PCH,0
# Sample Rate (usually 44.1kHz for internal audio)
jack_control dps rate 44100
# How big is the buffer
jack_control dps period 512
# How many buffers?
jack_control dps nperiods 2
# Extra ms latency
jack_control dps input_latency 24
jack_control dps output_latency 36
# Dithering: (r)ectangular, (t)riangle, (s)haped, (n)one
jack_control dps dither r

# START Jack Audio Server
jack_control stop
jack_control start
# START ALSA-to-JACK MIDI Bridge
#a2jmidid -e &
