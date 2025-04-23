#!/bin/sh

options="Disable | off\n🇫🇷   PIA - France | pia-france\n🇧🇪   PIA - Belgium | pia-belgium\n🇩🇪   PIA - Germany | pia-germany\n🇲🇩   PIA - Moldova | pia-moldova\n🇯🇵    PIA - Japan | pia-japan"

# display the Wofi menu and select a VPN
SELECTED=$(echo -e "$options" | wofi --dmenu --prompt "Select a VPN:" -W 300 -H 400 --hide-scroll --cache-file /dev/null)

# check if a selection was made
if [ -n "$SELECTED" ]; then
    # extract the path of the selected VPN
    SELECTED_PATH=$(echo "$SELECTED" | awk -F'|' '{print $2}' | xargs) # xargs is here for trimming the whitespace
    
    # toggle the VPN
    $HOME/.local/scripts/toggle_openvpn.sh $SELECTED_PATH
fi