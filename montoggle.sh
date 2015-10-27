#!/bin/bash

# Author: Milos Celic
# Twitter: @L05hMee

# When airmon-ng is giving you headaches.

usage="Usage: ./montoggle.sh <wireless_interface>"

if [[ $# < 1 ]]; then
    echo $usage
    exit 1
fi

interface=$1
error=$(ifconfig $interface 2>&1 | grep "Device not found")

if [[ $error ]]; then
    echo $usage
    exit 1
fi

mode=$(iwconfig $interface | grep Mode | cut -d":" -f2 | cut -d" " -f1)
ifconfig $interface down

if [ $mode = "Managed" ]; then
    iwconfig $interface mode monitor
elif [ $mode = "Monitor" ]; then
    iwconfig $interface mode managed
else
    echo $usage
fi

ifconfig $interface up
exit 0
