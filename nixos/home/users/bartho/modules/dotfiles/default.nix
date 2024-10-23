{ lib
, config
, pkgs
, username
, ...
}:

with lib;

let
  cfg = config.module.user.dotfiles;
  linkHomeFilesLib = import ../../../../../lib/link-home-files.nix { inherit config pkgs lib; };
in {
  options.module.user.dotfiles = {
    enable = mkEnableOption "Enables dotfiles";
  };

  config = mkIf cfg.enable {
    home = {
      file = linkHomeFilesLib.linkHomeFiles {
        # ".config" = {
        #   source = ../../../../../../dotfiles/.config;
        #   recursive = true;
        #   outOfStoreSymlink = true;
        # };
        ".local/share/wallpapers/nature" = {
          source = ../../../../../../dotfiles/.local/share/wallpapers/nature;
          recursive = true;
          outOfStoreSymlink = true;
        };
      };
    };
  };
}