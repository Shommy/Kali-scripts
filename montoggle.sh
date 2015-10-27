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
error_1=$(ifconfig $interface 2>&1 | grep "Device not found")

if [[ $error_1 ]]; then
    echo "Device $interface does not exist!"
    echo $usage
    exit 1
fi

error_2=$(iwconfig $interface 2>&1 | grep "no wireless extensions")

if [[ $error_2 ]]; then
    echo "$interface is not a wireless interface!"
    echo $usage
    exit 1
fi

mode=$(iwconfig $interface | grep Mode | cut -d":" -f2 | cut -d" " -f1)
ifconfig $interface down

if [ $mode = "Managed" ]; then
    iwconfig $interface mode monitor
    mode="monitor"
elif [ $mode = "Monitor" ]; then
    iwconfig $interface mode managed
    mode="managed"
else
    echo "Something went wrong :("
    echo $usage
fi

ifconfig $interface up
echo "$interface is now in $mode mode."
exit 0
