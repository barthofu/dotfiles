#!/bin/sh

# This script is used to connect to a Bluetooth device. It takes the name of the device as an argument and connects to it.

declare -A devices
devices["soundcore"]="E8:EE:CC:2E:2A:1B"
devices["enceinte-sony-salon"]="1C:D6:BE:95:96:FF"
devices["wonderboom-3"]="20:64:DE:98:07:DB"

device=$1

if [ -z "$device" ]; then
    echo "Usage: $0 <device>"
    exit 1
fi

if [ -z "${devices[$device]}" ]; then
    echo "Unknown device: $device"
    exit 1
fi

bluetoothctl power on

# get if the device is already connected
connected=$(bluetoothctl info ${devices[$device]} | grep "Connected: yes")
if [ -n "$connected" ]; then
    bluetoothctl disconnect ${devices[$device]}
else
    bluetoothctl connect ${devices[$device]}
fi

