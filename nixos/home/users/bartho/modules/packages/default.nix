{ config
, lib
, pkgs
, inputs
, isWorkstation
, wmEnable
, hyprlandEnable ? false
, ...
}:

with lib;

let
  inherit (pkgs.stdenv) isLinux;
  cfg = config.module.user.packages;
in {
  options.module.user.packages = {
    enable = mkEnableOption "Enable user packages";
  };

  config = mkIf cfg.enable {
    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [

    ] ++ lib.optionals isWorkstation [
      # Dev
      gitkraken
      jetbrains-toolbox
      # postman # TODO: not working, should install it using flatpak instead
      insomnia
      starship
      python3
      gh
      go

      # Media
      vlc
      spotify

      # Social
      vesktop
      teams-for-linux
      telegram-desktop
      signal-desktop

      # Utilities
      notion
      obsidian
      realvnc-vnc-viewer
      neatvnc
      cloudflare-warp
      pywal
      calc
      networkmanager_dmenu
      spacedrive
      smile
      # spotdl # spotify downloader # TODO: not working, find a fix or a correct working version
      scdl # soundcloud downloader
      
      # Web
      firefox

      # Games
      steam
      prismlauncher
    ] ++ lib.optionals hyprlandEnable [
      # screenshot
      grim
      slurp

      # utils
      # wl-ocr TODO: needs a derivation
      wl-clipboard
      wl-screenrec
      wlr-randr
      hypridle
      waybar
      xdg-utils
    ];
  };
}
