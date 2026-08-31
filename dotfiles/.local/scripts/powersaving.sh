#!/bin/sh

if [ -f ~/.cache/powersaving ] ;then
    hyprctl reload
    rm ~/.cache/powersaving
    powerprofilesctl set balanced
    notify-send "Powersaving mode deactivated" "Animations and blur enabled"
else
    hyprctl --batch "\
        keyword decoration:drop_shadow 0;\
        keyword decoration:blur:enabled 0;\
        keyword decoration:active_opacity 1;\
        keyword decoration:inactive_opacity 1;\
        misc:vfr = true;"
    powerprofilesctl set power-saver
	touch ~/.cache/powersaving
    notify-send "Powersaving mode activated" "Animations and blur disabled"
fi
