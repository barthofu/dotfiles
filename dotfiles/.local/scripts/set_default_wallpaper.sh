#!/bin/sh

# check if wallpaper exists
if [ ! -f "$HOME/.local/share/.current_wallpaper" ]; then
    $HOME/.local/scripts/set_wallpaper.sh aesthetic/dune.jpg
fi