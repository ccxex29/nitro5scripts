#!/bin/bash

pactl unload-module module-null-sink
pactl unload-module module-loopback
pactl unload-module module-remap-source
