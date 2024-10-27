#!/bin/sh

# Wallpaper directory
wallpapersDir="$HOME/.local/share/wallpapers"
cacheDir="$HOME/.cache/wallpapers"
mkdir -p "$cacheDir"

# Generate thumbnail for a wallpaper if it doesn't exist
generate_thumbnail() {
	local wallpaper="$1"
	local thumbnail="$cacheDir/${wallpaper#$wallpapersDir}"
	local thumbnailDir
	thumbnailDir=$(dirname "$thumbnail")
	
	# Create the directory structure for the cache
	mkdir -p "$thumbnailDir"
	
	# Check if the thumbnail already exists
	if [ ! -f "$thumbnail" ]; then
		# Generate a 256 px wide thumbnail
		convert "$wallpaper" -resize 256 "$thumbnail"
	fi
	
	echo "$thumbnail"
}

# Get the list of wallpapers
wallpapers=$(find "$wallpapersDir" -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" | sort)

# Loop to display the Wofi menu and select a wallpaper
while true; do
	# Prepare the wallpaper list for Wofi (format: img:<path>:text:<filename>)
	wallpaperList=""
	for wallpaper in $wallpapers; do
		thumbnail=$(generate_thumbnail "$wallpaper")
		wallpaperList="${wallpaperList}img:${thumbnail}:text:$(echo $wallpaper | sed "s|$wallpapersDir||")\n"
	done

	# Launch Wofi with the wallpaper menu
	SELECTED=$(echo -e "$wallpaperList" | wofi --dmenu --allow-images --prompt "Select a wallpaper:")

	# Check if a selection was made
	if [ -n "$SELECTED" ]; then
		# Extract the path of the selected wallpaper
		SELECTED_PATH=$(echo "$SELECTED" | awk -F: '{print $4}')
		
		# Set the wallpaper
		$HOME/.local/scripts/set_wallpaper.sh "$SELECTED_PATH"
	else
		# Exit the loop if no selection is made (e.g., user closes Wofi or presses ESC)
		break
  fi
done