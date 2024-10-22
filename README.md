# Dotfiles

## File structure

```bash
.
├── nixos
│   ├── flake.nix # configuration entry point
│   ├── home # home-manager configuration
│   │   ├── modules # home-manager modules
│   │   └── users # users configurations for home manager 
│   ├── 

```

## NixOS

### Installation

**Network:**
1. Run `rfkill unblock all` to unblock all network devices at a software level.
2. `systemctl start wpa_supplicant`
3. Grab your wireless interface name by running `iwconfig`
4. Up your wireless interface by running `ifconfig <interface_id> up`
5. Run `wpa_passphrase "<ssid>" "<password>" | tee /etc/wpa_supplicant.conf` to generate a wpa_supplicant.conf file.
6. Run `wpa_supplicant -B -c /etc/wpa_supplicant.conf -i <interface_id>` to connect to the network in the background.
7. If you don't directly have an IP adress, run `dhclient <interface_id>` to get one.

### Utilities commands

- `lsblk -o name,uuid | grep nvme0n1p3 | awk '{print $NF}'` to get the UUID of the partition

### Todo

