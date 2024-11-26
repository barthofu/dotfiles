#!/bin/sh

# Toggle on/off tailscale or set status if an arg is present
# Usage: toggle_tailscale.sh [up|down]

wanted_status=$1
if sudo tailscale status | grep "Tailscale is stopped"; then
    current_status="down"
else
    current_status="up"
fi

# function to up tailscale
up() {
    sudo tailscale up --accept-routes --hostname bartho-lenovo-nixos
    notify-send "Tailscale is up"
}

# function to down tailscale
down() {
    sudo tailscale down
    notify-send "Tailscale is down"
}

if [ "$wanted_status" = "up" ] && [ "$currrent_status" = "down" ]; then
    up
elif [ "$wanted_status" = "down" ]  && [ "$currrent_status" = "up" ]; then
    down
elif [ "$current_status" = "down" ]; then
    up
elif [ "$current_status" = "up" ]; then
    down
fi
