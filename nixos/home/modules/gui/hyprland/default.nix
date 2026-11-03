{ config
, lib
, inputs
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.gui.hyprland;
  swayBgEnabled = config.module.gui.swaybg.enable;
  cliphistEnabled = config.module.utils.cliphist.enable;

  hyprlandPkg = import ../../../../lib/hyprland.nix { inherit inputs pkgs; };

  # Upstream recipe, built against our Hyprland; gcc14Stdenv would mismatch hyprutils' libstdc++.
  virtualDesktops = pkgs.callPackage "${inputs.hyprland-virtual-desktops}/default.nix" {
    hyprland = hyprlandPkg;
    gcc14Stdenv = pkgs.stdenv;
    lua = pkgs.lua5_5;
  };
in {
  options.module.gui.hyprland = {
    enable = mkEnableOption "Enables hyprland";
  };

  config = mkIf cfg.enable {

    xdg.configFile."hypr/lua".source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/.dotfiles/dotfiles/.config/hypr/lua";

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      #package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      package = null;
      portalPackage = null;
      configType = "lua";

      plugins = [
        virtualDesktops
      ];

      extraConfig = ''
        package.path = (os.getenv("XDG_CONFIG_HOME") or os.getenv("HOME") .. "/.config") .. "/hypr/?.lua;" .. package.path

        hl.config({
          plugin = {
            virtual_desktops = {
              names = "1, 2, 3, 4, 5, 6, 7, 8, 9",
              cycleworkspaces = 1,
              rememberlayout = "size",
              notifyinit = 0,
              verbose_logging = 0,
            },
          },
        })

        require("lua.settings")
        require("lua.visuals")
        require("lua.transparency")
        require("lua.bindings")
        require("lua.startup")

        hl.on("hyprland.start", function()
          ${optionalString cliphistEnabled ''hl.exec_cmd("cliphist wipe; wl-paste --watch cliphist store")''}
          hl.exec_cmd("/run/wrappers/bin/sudo -n /run/current-system/sw/bin/reset-mouse-dongle > /tmp/reset-mouse-dongle.log 2>&1")
        end)
      '';

      # plugins = with inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}; [
      #     hyprbars
      #     hyprexpo
      # ];

      systemd = {
        variables = ["--all"];
        extraCommands = [
          "systemctl --user stop graphical-session.target"
          "systemctl --user start hyprland-session.target"
        ];
      };
    };
  };
}
