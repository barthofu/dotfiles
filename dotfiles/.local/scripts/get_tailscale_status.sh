#!/bin/sh

# Get tailscale status for Waybar

if sudo tailscale status | grep -q "Tailscale is stopped"; then
    current_status="down"
else
    current_status="up"
fi

echo "{ \"text\":\"\", \"class\": \"$current_status\" }"