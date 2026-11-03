#!/bin/sh

if [ -f ~/.cache/transparency ] ;then
    rm ~/.cache/transparency
    if ! hyprctl -j getoption animations:enabled | jq -e 'has("bool")' >/dev/null; then
        sed -i 's/source = ~\/.config\/hypr\/conf\/transparency.conf/#source = ~\/.config\/hypr\/conf\/transparency.conf/g' ~/.dotfiles/dotfiles/.config/hypr/hyprland-source.conf
    fi
    hyprctl reload
    notify-send "Transparency deactivated"
else
    touch ~/.cache/transparency
    if ! hyprctl -j getoption animations:enabled | jq -e 'has("bool")' >/dev/null; then
        sed -i 's/#source = ~\/.config\/hypr\/conf\/transparency.conf/source = ~\/.config\/hypr\/conf\/transparency.conf/g' ~/.dotfiles/dotfiles/.config/hypr/hyprland-source.conf
    fi
    hyprctl reload
    notify-send "Transparency activated"
fi