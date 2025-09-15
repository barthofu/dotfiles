#!/usr/bin/env bash

# Script pour waybar - indicateur d'enregistrement d'écran
STATUS_FILE="/tmp/screen_recording_status"

if [ -f "$STATUS_FILE" ]; then
    cat "$STATUS_FILE"
else
    echo '{"text": "", "tooltip": "Pas d'\''enregistrement", "class": "not-recording"}'
fi
