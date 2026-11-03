#!/bin/sh
if hyprctl -j getoption animations:enabled | jq -e 'has("bool")' >/dev/null; then
	hyprctl dispatch 'hl.dsp.window.pin()'
else
	addr=$(hyprctl activewindow -j | jq -r .address)
	hyprctl keyword windowrulev2 "stayontop, address:$addr"
fi
