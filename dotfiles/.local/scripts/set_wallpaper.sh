#!/bin/sh

BASE_DIR="$HOME/.local/share/wallpapers"
CURRENT_WALLPAPER_PATH="$HOME/.local/share/.current_wallpaper"

path=$1
if [ -z "$path" ]; then
    echo "Usage: $0 <wallpaper_sub_path>"
    exit 1
fi

full_path="$BASE_DIR/$path"
if [ ! -f "$full_path" ]; then
    echo "Wallpaper not found: $base_dir/$path"
    exit 1
fi

# change current wallpaper file
cp -f "$full_path" "$CURRENT_WALLPAPER_PATH"

# set wallpaper
swaybg -i "$CURRENT_WALLPAPER_PATH" -m fill &

# re-generate color scheme
wal -c
wal -nqsti "$CURRENT_WALLPAPER_PATH" -a 0 --backend colors

# reload waybar
$HOME/.local/scripts/reload_waybar.sh