#!/bin/bash
#     _    _ _  __ _             _    
#    / \  | | |/ _| | ___   __ _| |_  
#   / _ \ | | | |_| |/ _ \ / _` | __| 
#  / ___ \| | |  _| | (_) | (_| | |_  
# /_/   \_\_|_|_| |_|\___/ \__,_|\__| 
#                                     

if hyprctl -j getoption animations:enabled | jq -e 'has("bool")' >/dev/null; then
	hyprctl eval 'require("lua.actions").toggle_all_float()'
else
	hyprctl dispatch workspaceopt allfloat
fi
notify-send "Windows on this workspace toggled to floating/tiling"
