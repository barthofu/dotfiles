# Hyprland Migration to Lua

This repository's configuration is prepared for Lua with Hyprland **0.56.2** and
the `virtual-desktops` plugin **2.2.8**. Hyprland 0.57 has not yet been tested:
recheck the APIs and plugin compatibility when upgrading. The wiki documentation
on `main` may describe a newer version than the one used here.

## Sources

- [0.56 release notes](https://github.com/hyprwm/Hyprland/releases/tag/v0.56.0)
- [Example Lua configuration for 0.56.2](https://raw.githubusercontent.com/hyprwm/Hyprland/v0.56.2/example/hyprland.lua)
- [virtual-desktops plugin and its Lua API](https://github.com/levnikmyskin/hyprland-virtual-desktops)
- [Startup and events](https://github.com/hyprwm/hyprland-wiki/blob/main/content/configuring/core/autostart.md)
- [Dispatchers](https://github.com/hyprwm/hyprland-wiki/blob/main/content/configuring/core/dispatchers.md)
- [Keybindings](https://github.com/hyprwm/hyprland-wiki/blob/main/content/configuring/core/binds/_index.md), [keybinding flags](https://github.com/hyprwm/hyprland-wiki/blob/main/content/configuring/core/binds/flags.md) and [switches](https://github.com/hyprwm/hyprland-wiki/blob/main/content/configuring/core/binds/switches.md)
- [Monitors](https://github.com/hyprwm/hyprland-wiki/blob/main/content/configuring/core/monitors/_index.md) and [devices](https://github.com/hyprwm/hyprland-wiki/blob/main/content/configuring/core/devices.md)
- [Animations](https://github.com/hyprwm/hyprland-wiki/blob/main/content/configuring/core/animations.md) and [window rules](https://github.com/hyprwm/hyprland-wiki/blob/main/content/configuring/core/rules/window-rules.md)
- [hyprctl commands](https://github.com/hyprwm/hyprland-wiki/blob/main/content/configuring/core/advanced-configuration/using-hyprctl.md)

The exact declarations for the current installation are also available in
`/run/current-system/sw/share/hypr/stubs/hl.meta.lua`.

## Organization and Differences

Home Manager generates `~/.config/hypr/hyprland.lua`, loads the plugin and points
`~/.config/hypr/lua` to `dotfiles/.config/hypr/lua` in this repository. The old
Hyprlang files are kept to make rollback easier. Scripts available in the
current session distinguish the old parser from Lua using the output of
`hyprctl -j getoption animations:enabled`.

With Lua, `hyprctl keyword` is replaced by `hyprctl eval`, and dispatchers
accept expressions such as `hyprctl dispatch 'hl.dsp.exit()'`. Transparency
rules are reloaded from `~/.cache/transparency`. The floating toggle shortcut
acts on currently open windows, because the old `workspaceopt allfloat` no
longer works in 0.56. The `XF86Lock` shortcut has been replaced by
`XF86ScreenSaver` and must be tested on the physical keyboard.

## Verification and Activation

The generated configuration and plugin have been tested in a nested 0.56.2
compositor without running the session startup or shutdown commands.
`Hyprland --verify-config` does not load plugins, and its exit code does not
necessarily indicate errors: check its output and test the plugin in a real
instance. Monitors, the laptop lid and application startup still need to be
verified on the machine.

To build and activate after review:

```sh
sudo nixos-rebuild switch --flake ~/.dotfiles/nixos#lenovo
```

Log out and back into the Hyprland session to apply the new parser. A previous
NixOS generation can be used to return to the earlier configuration.