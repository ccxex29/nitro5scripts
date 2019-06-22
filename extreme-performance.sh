#!/bin/bash

#Similar to batterysave. This time it will not have any consent on battery.
#It will try to push the system's limit to the edge.

echo 'performance' | sudo tee /sys/devices/system/cpu/cpufreq/policy*/energy_performance_preference