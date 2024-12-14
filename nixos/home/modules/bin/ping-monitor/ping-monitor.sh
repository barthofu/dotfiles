#!/bin/sh

# spawn alacritty window with gping
alacritty --class gping -t "gping 8.8.8.8" -e gping 8.8.8.8