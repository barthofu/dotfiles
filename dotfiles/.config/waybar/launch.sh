#!/bin/sh

config="default"
theme="macchiato"

# ----------------------------------------------------- 
# Quit all running waybar instances
# ----------------------------------------------------- 
killall waybar
pkill waybar
sleep 0.5

# ----------------------------------------------------- 
# Loading the configuration
# ----------------------------------------------------- 
# Check if waybar-disabled file exists
if [ ! -f $HOME/.cache/waybar-disabled ] ;then 
	waybar -c ~/.config/waybar/configs/$config/config.jsonc -s ~/.config/waybar/configs/$config/themes/$theme.css &
fi