#!/bin/sh

# This script is used to connect to a Bluetooth device. It takes the name of the device as an argument and connects to it.

declare -A devices
devices["soundcore"]="E8:EE:CC:2E:2A:1B"
devices["enceinte-sony-salon"]="1C:D6:BE:95:96:FF"
devices["wonderboom-3"]="20:64:DE:98:07:DB"
devices["bp50"]="00:02:5B:00:FF:06"

device=$1

if [ -z "$device" ]; then
    echo "Usage: $0 <device>"
    exit 1
fi

mac_address="${devices[$device]}"

if [ -z "$mac_address" ]; then
    echo "Unknown device: $device"
    exit 1
fi

rfkill unblock bluetooth
bluetoothctl power on
sleep 3
bluetoothctl scan on
sleep 2
bluetoothctl disconnect ${mac_address}
sleep 2
bluetoothctl untrust ${mac_address}
sleep 2
bluetoothctl remove ${mac_address}
sleep 2
bluetoothctl scan off
sleep 2
bluetoothctl power off
sleep 2
bluetoothctl power on
sleep 3
bluetoothctl scan on
sleep 4
bluetoothctl connect ${mac_address}
sleep 5
bluetoothctl trust ${mac_address}
sleep 2
bluetoothctl scan off





# # get if the device is already connected
# connected=$(bluetoothctl info ${devices[$device]} | grep "Connected: yes")
# if [ -n "$connected" ]; then
#     bluetoothctl disconnect ${devices[$device]}
# else
#     bluetoothctl connect ${devices[$device]}
# fi

