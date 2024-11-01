#!/bin/sh

# Remove gamemode flag
if [ -f ~/.cache/gamemode ] ;then
    rm ~/.cache/gamemode
    echo ":: ~/.cache/gamemode removed"
fi

# Remove powersaving flag
if [ -f ~/.cache/powersaving ] ;then
    rm ~/.cache/powersaving
    echo ":: ~/.cache/powersaving removed"
fi