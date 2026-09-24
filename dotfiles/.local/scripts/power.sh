#!/bin/sh

if [[ "$1" == "logout" ]]; then
    echo ":: Logout"
    sleep 0.5
    # graceful exit (unloads plugins, tears down hyprland-session.target)
    # instead of pkill Hyprland, which orphans clients and left stale
    # systemd/portal state that hung the *next* logout
    hyprctl dispatch exit
fi

if [[ "$1" == "lock" ]]; then
    echo ":: Lock"
    sleep 0.5
    hyprlock    
fi

if [[ "$1" == "reboot" ]]; then
    echo ":: Reboot"
    sleep 0.5
    systemctl reboot
fi

if [[ "$1" == "shutdown" ]]; then
    echo ":: Shutdown"
    sleep 0.5
    systemctl poweroff
fi

if [[ "$1" == "suspend" ]]; then
    echo ":: Suspend"
    sleep 0.5
    systemctl suspend    
fi

if [[ "$1" == "hibernate" ]]; then
    echo ":: Hibernate"
    sleep 1; 
    systemctl hibernate    
fi