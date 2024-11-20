#!/bin/sh

if [ -f ~/.cache/transparency ] ;then
    sed -i 's/source = ~\/.config\/hypr\/conf\/transparency.conf/#source = ~\/.config\/hypr\/conf\/transparency.conf/g' ~/.dotfiles/dotfiles/.config/hypr/hyprland-source.conf
    hyprctl reload
    rm ~/.cache/transparency
    notify-send "Transparency deactivated"
else
    sed -i 's/#source = ~\/.config\/hypr\/conf\/transparency.conf/source = ~\/.config\/hypr\/conf\/transparency.conf/g' ~/.dotfiles/dotfiles/.config/hypr/hyprland-source.conf
    hyprctl reload
    touch ~/.cache/transparency
    notify-send "Transparency activated"
fi