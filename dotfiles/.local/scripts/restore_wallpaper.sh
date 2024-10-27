#!/bin/sh

# restore wallpaper
$HOME/.local/scripts/set_default_wallpaper.sh
swaybg -i "$HOME/.local/share/.current_wallpaper" -m fill &