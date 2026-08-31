# Todo

*There is also inline TODOs in the different files, just ctrl+maj+F to find them*

## Global

- [ ] brand the whole repo and this project as "SietchOS" (use ascii generator for the logo)
- [ ] check gc and nixos storage optimization
- [ ] automatic last nixos generation chooser (would be could to do a key combination in order to select the generation)
- [ ] move boot system module to system configuration
- [ ] dig the iso creation process (https://github.com/erictossell/nixflakes/blob/main/docs/installation-media.md)

## Current problems

*Problems are sorted from highest priority to lowest.*

- [ ] hibernate crashes the system (sometimes?)
- [ ] closing the lid has an unstable behavior (sometimes it hibernates, sometimes it doesn't)
- [ ] performance problem on games
- [ ] 2.4ghz mouse bugged on login (reacts with delay, fixed by reconnecting the dongle after login - udev autosuspend rule didn't fix it; now trying a `reset-mouse-dongle` script (usb unbind/bind on 046d:c539) run via `exec-once` in hyprland on login, needs testing)
- [ ] vscode discord rpc connection not working
- [ ] windows random freezing (quite rare tho)
- [ ] discord vscode rich presence not working (open an issue)

## Environment

- [ ] configure gdm or sddm
- [ ] ~~global system dark mode so apps can inherit it (e.g: chrome)~~
- [x] add a dynamic option to change power mode (powersave, performance, etc) on fly
- [x] apps auto-launch and disposition across workspaces at startup (hyprland related)
- [ ] selectable display mode when external monitor connected (same as Windows; duplicate, extend and only 2nd screen) -> autorandr?
- [ ] gui for when typing in my encrypted disk code
- [ ] hyprland
  - [ ] make bitwarden popup float (https://github.com/hyprwm/Hyprland/issues/3835)
- [ ] swaync
  - [ ] style the bar
    - https://github.com/erikreider/swaynotificationcenter/discussions/183
    - https://github.com/erikreider/swaynotificationcenter/discussions/183#discussioncomment-7734063
  - [ ] style the notifications

## Scripts

- [ ] formatter
- [ ] *generators (modules)*

## Apps

- [ ] gpg?
- [ ] vnc server + client (for mobile)
- [ ] fix geoclue2
- [ ] piaé