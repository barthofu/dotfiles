#!/bin/sh

# Script to toggle between different OpenVPNs
# Usage: toggle_openvpn.sh <vpn_name>

# get vpn argument
wanted_vpn=$1

# get all possible vpns from configuration files available at /root/.vpn
vpns=$(ls /etc/vpn/*.ovpn)

for vpn in $vpns; do
    # get vpn name
    vpn_name=$(basename $vpn .ovpn)
    # check if vpn is already running
    current=$(systemctl is-active --quiet openvpn-${vpn_name} && echo "active" || echo "inactive")
    # if vpn is active, stop it
    if [ $wanted_vpn = $vpn_name ]; then
        if [ $current = "inactive" ]; then
            sudo systemctl start openvpn-${vpn_name}
            notify-send "VPN $vpn_name started"
        elif [ $current = "active" ]; then
            sudo systemctl stop openvpn-${vpn_name}
            notify-send "VPN $vpn_name stopped"
        fi
    elif [ $current = "active" ]; then
        sudo systemctl stop openvpn-${vpn_name}
        notify-send "VPN $vpn_name stopped"
    fi
done