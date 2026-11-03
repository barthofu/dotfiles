#!/bin/sh

option=$(hyprctl -j getoption animations:enabled)
on=$(printf '%s\n' "$option" | jq --raw-output 'if .bool != null then .bool else .int == 1 end')
lua=$(printf '%s\n' "$option" | jq -e 'has("bool")' >/dev/null && printf true)

if [ "$on" = true ]; then
    if [ "$lua" = true ]; then
        hyprctl eval 'hl.config({ animations = { enabled = false } })'
    else
        hyprctl keyword animations:enabled 0
    fi
    hyprctl notify -1 1000 "rgb(e06c75)" "Animations off"
else
    if [ "$lua" = true ]; then
        hyprctl eval 'hl.config({ animations = { enabled = true } })'
    else
        hyprctl keyword animations:enabled 1
    fi
    hyprctl notify -1 1000 "rgb(98c379)" "Animations on"
fi