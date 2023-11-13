# Dotfiles

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

### Todo

*There is also inline TODOs in the different files, just ctrl+maj+F to find them*

#### Global

- [ ] check if my gpu is correctly working
- [ ] printer

#### Scripts

- [ ] formatter
- [ ] check imports on pre-commit
- [ ] *generators (programs)*

#### Home Manager

- [x] atuin: better shell history
- [x] zsh
- [x] oh-my-zsh
- [ ] i3
- [ ] i3lock
- [x] btop
- [x] eza
- [ ] nvim
- [x] firefox (ou chrome encore et toujours ?)
- [ ] gh
- [x] git
- [ ] gpg ?
- [ ] himalaya