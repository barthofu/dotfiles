#!/usr/bin/env bash
# Toggle a "powersaving" mode: disables Hyprland eye-candy and switches the
# power profile. Also exposed as a Waybar custom module (status/toggle).

STATE_FILE="$HOME/.cache/powersaving"
# nf-fa-leaf / nf-fa-bolt, written as escapes to avoid encoding mishaps
ICON_ON=$'\uf06c'
ICON_OFF=$'\uf0e7'

status() {
    if [ -f "$STATE_FILE" ]; then
        echo "{\"text\":\"$ICON_ON\",\"tooltip\":\"Powersaving mode <span color=\\\"#ee99a0\\\">on</span>\\nClick to disable\",\"class\":\"on\"}"
    else
        echo "{\"text\":\"$ICON_OFF\",\"tooltip\":\"Powersaving mode <span color=\\\"#a6da95\\\">off</span>\\nClick to enable\",\"class\":\"off\"}"
    fi
}

toggle() {
    if [ -f "$STATE_FILE" ]; then
        hyprctl reload
        rm -f "$STATE_FILE"
        command -v powerprofilesctl >/dev/null 2>&1 && powerprofilesctl set balanced
        notify-send "Powersaving mode deactivated" "Animations and blur enabled"
    else
        hyprctl --batch "\
            keyword decoration:drop_shadow 0;\
            keyword decoration:blur:enabled 0;\
            keyword decoration:active_opacity 1;\
            keyword decoration:inactive_opacity 1;\
            keyword misc:vfr true"
        command -v powerprofilesctl >/dev/null 2>&1 && powerprofilesctl set power-saver
        touch "$STATE_FILE"
        notify-send "Powersaving mode activated" "Animations and blur disabled"
    fi
}

case "$1" in
    status) status ;;
    toggle|"") toggle ;;
    *) echo "Usage: $0 {status|toggle}" >&2; exit 1 ;;
esac
