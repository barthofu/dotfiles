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

      # Media
      vlc
      spotify

      # Social
      discord
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
      # spotdl # spotify downloader # TODO: not working, find a fix or a correct working version
      scdl # soundcloud downloader
      feh # manage wallpapers

      # Web
      firefox
    ] ++ lib.optionals hyprlandEnable [
      # screenshot
      grim
      slurp

      # utils
      # self.packages.${pkgs.system}.wl-ocr
      wl-clipboard
      wl-screenrec
      wlr-randr
    ];
  };
}
