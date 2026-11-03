#!/bin/bash
#  __  __                  _        
# |  \/  | _____   _____  | |_ ___  
# | |\/| |/ _ \ \ / / _ \ | __/ _ \ 
# | |  | | (_) \ V /  __/ | || (_) |
# |_|  |_|\___/ \_/ \___|  \__\___/ 
#                                  

# Function to log messages (useful for debugging)
log_message() {
    # echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> ~/moveto_log.txt
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# Get the target workspace from the argument
target_workspace=$1

# Check if a target workspace was provided
if [ -z "$target_workspace" ]; then
    log_message "Error: No target workspace provided"
    exit 1
fi

# Get the current active workspace
current_workspace=$(hyprctl activewindow -j | jq '.workspace.id')

if [ -z "$current_workspace" ]; then
    log_message "Error: Couldn't determine current workspace"
    exit 1
fi

log_message "Moving from workspace $current_workspace to $target_workspace"

# Get all window addresses in the current workspace
window_addresses=$(hyprctl clients -j | jq -r ".[] | select(.workspace.id == $current_workspace) | .address")
target_json=$(jq -Rn --arg value "$target_workspace" '$value')
lua=$(hyprctl -j getoption animations:enabled | jq -e 'has("bool")' >/dev/null && printf true)

# Move each window to the target workspace
for address in $window_addresses; do
    log_message "Moving window $address to workspace $target_workspace"
    if [ "$lua" = true ]; then
        address_json=$(jq -Rn --arg value "address:$address" '$value')
        hyprctl dispatch "hl.dsp.window.move({ workspace = $target_json, window = $address_json, follow = false })"
    else
        hyprctl dispatch movetoworkspacesilent "$target_workspace,address:$address"
    fi
done

log_message "Finished moving windows"

# Switch to the target workspace
if [ "$lua" = true ]; then
    hyprctl dispatch "hl.dsp.focus({ workspace = $target_json })"
else
    hyprctl dispatch workspace "$target_workspace"
fi

log_message "Switched to workspace $target_workspace"