#!/bin/sh

# This script is used to organize the screens of my laptop.

# constants
INTERNAL_SCREEN="eDP-1"

# variables
lid_status=$(cat /proc/acpi/button/lid/LID0/state | awk '{print $2}')
external_monitor=$(hyprctl monitors | grep "Monitor" | grep -v "$INTERNAL_SCREEN" | awk '{print $2}' | head -n 1)

if [ -n "$external_monitor" ] && [ $lid_status == "closed" ]; then
    hyprctl keyword monitor "$INTERNAL_SCREEN, disable"
else
    hyprctl reload
fi