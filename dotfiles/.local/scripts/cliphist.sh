#!/bin/sh

cliphist list | wofi --dmenu --allow-images --pre-display-cmd "cliphist-wofi-img-go %s" | cliphist decode | wl-paste