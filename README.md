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
- [ ] re-organize things between nixos and home-manager
- [ ] re-organize things between shared and host-specific
- [ ] limit max number of archived generations
- [ ] trackpad pinch-to-zoom support (especialy in Chrome)
- [ ] better looking lockscreens
- [ ] pin code to unlock session
- [ ] check gc and nixos storage optimization
- [ ] better control over sound control (limit to 100% or 150%)
- [ ] dig power consumption in order to have better battery life
    - [ ] make comparisons tests against Windows 
- [ ] global system dark mode so apps can inherit it (e.g: chrome)

#### Scripts

- [ ] formatter
- [ ] check imports on pre-commit
- [ ] *generators (programs)*

#### Home Manager

- [x] atuin: better shell history
- [x] zsh
- [x] oh-my-zsh
- [x] btop
- [x] eza
- [x] firefox (ou chrome encore et toujours ?)
- [x] git
- [x] alacritty
- [ ] nvim
- [ ] gh
- [ ] gpg ?
- [ ] himalaya
- [ ] conky
- [ ] navi
- [ ] vscode (instead of codium)
    - [ ] w/ declarative extensions
    - [ ] w/ declarative keybindings 

#### i3 related
- [x] i3
- [x] i3lock
- [x] rofi
- [x] picom
- [ ] polybar
- [ ] dunst
- [ ] pywal
- [ ] autorandr (if i have problems with external monitors)
- [ ] bumblebee-status (?)