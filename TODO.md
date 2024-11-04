# Todo

*There is also inline TODOs in the different files, just ctrl+maj+F to find them*

## Global

- [ ] continuous integration
- [ ] check gc and nixos storage optimization
- [ ] automatic last nixos generation chooser (would be could to do a key combination in order to select the generation)
- [ ] move boot system module to system configuration
- [ ] add a dynamic option to change power mode (powersave, performance, etc) on fly
- [ ] dig the iso creation process (https://github.com/erictossell/nixflakes/blob/main/docs/installation-media.md)

## Current problems

*Problems are sorted from highest priority to lowest.*

- [ ] hibernate crashes the system (sometimes?)
- [ ] closing the lid has an unstable behavior (sometimes it hibernates, sometimes it doesn't)
- [ ] discord, git and wifi not keeping session between launches
  - [ ] maybe cause by not using any keyring service?
- [ ] workspaces not stable (often desynchronized on multiple monitors, and other random bugs)
- [ ] cursor styling 
- [ ] performance problem on games
- [ ] bt speaker wonderboom 3 not connecting
- [ ] 2.4ghz mouse bugged on login
- [ ] discord opening on workspace 1 instead of workspace 3 because of mouse focus
  -> focus workspace 3 at hyprland launch, sleep for some time and then focus workspace 1
- [ ] swaync not showing many notifications (maybe normal as i don't have any notifs in my apps by default?)
- [ ] vscode discord rpc connection not working
- [ ] windows random freezing (quite rare tho)
- [ ] discord vscode rich presence not working (open an issue)

## Environment

- [ ] configure gdm or sddm
- [ ] global system dark mode so apps can inherit it (e.g: chrome)
- [ ] apps auto-launch and disposition across workspaces at startup (hyprland related)
- [ ] selectable display mode when external monitor connected (same as Windows; duplicate, extend and only 2nd screen) -> autorandr?
- [ ] gui for when typing in my encrypted disk code
- [ ] hyprland
  - [ ] make bitwarden popup float (https://github.com/hyprwm/Hyprland/issues/3835)
- [ ] swaync
  - [ ] style the bar
    - https://github.com/erikreider/swaynotificationcenter/discussions/183
    - https://github.com/erikreider/swaynotificationcenter/discussions/183#discussioncomment-7734063

## Scripts

- [ ] formatter
- [ ] *generators (modules)*

## Apps

- [ ] nvim with fully-fledged config
- [ ] gpg?
- [ ] fix geoclue2
- [ ] pia
- [x] syncthing
- [x] tailscale
- [x] vesktop