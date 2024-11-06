{ config
, pkgs-master
, lib
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.dev.vim;
in {
  options.module.dev.vim = {
    enable = mkEnableOption "Enables vim";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      lunarvim
    ];
  };
}