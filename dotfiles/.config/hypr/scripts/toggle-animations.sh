#!/bin/bash
cache_file="$HOME/.cache/toggle_animation"
if [[ $(cat $HOME/.config/hypr/conf/animation.conf) == *"disabled"* ]]; then
    echo ":: Toggle blocked by disabled.conf variation."
else
    if [ -f $cache_file ] ;then
        if hyprctl -j getoption animations:enabled | jq -e 'has("bool")' >/dev/null; then
            hyprctl eval 'hl.config({ animations = { enabled = true } })'
        else
            hyprctl keyword animations:enabled 1
        fi
        rm $cache_file
    else
        if hyprctl -j getoption animations:enabled | jq -e 'has("bool")' >/dev/null; then
            hyprctl eval 'hl.config({ animations = { enabled = false } })'
        else
            hyprctl keyword animations:enabled 0
        fi
        touch $cache_file
    fi
fi