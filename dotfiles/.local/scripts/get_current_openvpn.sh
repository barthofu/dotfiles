#!/bin/sh

# Script to get current openvpn status for Waybar
# Usage: get_current_openvpn.sh

# get all possible vpns from configuration files available at /root/.vpn
vpns=$(ls /etc/vpn/*.ovpn)

icon=""
found_first=0
for vpn in $vpns; do
    # get vpn name
    vpn_name=$(basename $vpn .ovpn)
    # check if vpn is already running
    current=$(systemctl is-active --quiet openvpn-${vpn_name} && echo "active" || echo "inactive")
    if [ $current = "active" ]; then
        if [ $vpn_name = "pia-moldova" ]; then
            icon="🇲🇩"
        elif [ $vpn_name = "pia-france" ]; then
            icon="🇫🇷"
        elif [ $vpn_name = "pia-belgium" ]; then
            icon="🇧🇪"
        elif [ $vpn_name = "pia-italy" ]; then
            icon="🇮🇹"
        elif [ $vpn_name = "pia-germany" ]; then
            icon="🇩🇪"
        elif [ $vpn_name = "pia-japan" ]; then
            icon="🇯🇵"
        fi
        break
    fi
done

echo "{ \"text\":\"$icon\", \"class\": \"$current\" }"