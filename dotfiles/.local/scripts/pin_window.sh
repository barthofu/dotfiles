#!/bin/sh
addr=$(hyprctl activewindow -j | jq -r .address)
hyprctl keyword windowrulev2 "stayontop, address:$addr"
