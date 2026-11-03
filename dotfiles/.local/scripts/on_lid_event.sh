#!/bin/sh

# This script is used to organize the screens of my laptop.

# constants
INTERNAL_SCREEN="eDP-1"

# variables
lid_status=$(cat /proc/acpi/button/lid/LID0/state | awk '{print $2}')
external_monitor=$(hyprctl monitors | grep "Monitor" | grep -v "$INTERNAL_SCREEN" | awk '{print $2}' | head -n 1)

if [ -n "$external_monitor" ] && [ $lid_status == "closed" ]; then
    if hyprctl -j getoption animations:enabled | jq -e 'has("bool")' >/dev/null; then
        hyprctl eval 'hl.monitor({ output = "eDP-1", disabled = true })'
    else
        hyprctl keyword monitor "eDP-1, disable"
    fi
else
    hyprctl reload
fi