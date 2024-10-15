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

### Utilities commands

- `lsblk -o name,uuid | grep nvme0n1p3 | awk '{print $NF}'` to get the UUID of the partition

### Todo

*There is also inline TODOs in the different files, just ctrl+maj+F to find them*

#### Global

- [ ] continuous integration
- [ ] check gc and nixos storage optimization
- [ ] dig power consumption in order to have better battery life
    - [ ] make comparisons tests against Windows 
    - [ ] check if the GPU is correctly working
    - [ ] check c-states
- [ ] automatic last nixos generation chooser (would be could to do a key combination in order to select the generation)
- [ ] re-organize things between nixos and home-manager
- [ ] re-organize things between shared and host-specific
  
#### Environment

- [ ] **switch to wayland**
    - [ ] touchpad pinch-to-zoom support (especialy in Chrome)
    - [ ] fix this godamn dpi/scaling issue with my monitors
- [ ] better looking lockscreens
- [ ] pin code to unlock session
- [ ] better control over sound control (limit to 100% or 150% via script)
- [ ] global system dark mode so apps can inherit it (e.g: chrome)
- [ ] apps auto-launch and disposition across workspaces at startup (i3 related)
- [ ] docked / portable modes: make distinct modes for when i'm docked and when i'm not (this could impact GPU performance settings, screens resolutions, apps auto-launch at startup, etc) -> autorandr?
- [ ] gui for when typing in my encrypted disk code
- [ ] selectable display mode when external monitor connected (same as Windows; duplicate, extend and only 2nd screen) -> autorandr?
- [ ] win+maj+S equivalent of windows (to take localized screenshots)
- [ ] screen color picker
- [ ] practical wifi manager with 5ghz support (wtf?)
- [ ] check if my gpu is correctly working

#### Scripts

- [ ] formatter
- [ ] check imports on pre-commit
- [ ] *generators (programs)*

#### Apps

##### Home Manager

- [x] atuin: better shell history
- [x] zsh
- [x] oh-my-zsh
- [x] btop
- [x] eza
- [x] firefox (ou chrome encore et toujours ?)
- [x] git
- [x] alacritty
- [ ] vnc server
- [ ] nvim
- [ ] gh
- [ ] gpg ?
- [ ] himalaya
- [ ] conky
- [ ] navi
- [ ] vscode (instead of codium)
    - [ ] w/ declarative extensions
    - [ ] w/ declarative keybindings 

##### i3 related
- [x] i3
- [x] i3lock
- [x] rofi
- [x] picom
- [ ] polybar
- [ ] dunst
- [ ] pywal
- [ ] autorandr (if i have problems with external monitors)
- [ ] bumblebee-status (?)

##### Games
- [ ] wine
- [ ] lutris

##### Dev
- [ ] rust
- [ ] golang
- [x] python
- [x] node