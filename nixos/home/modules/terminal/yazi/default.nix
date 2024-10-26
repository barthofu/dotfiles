{ config
, lib
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.terminal.yazi;
in {
  options.module.terminal.yazi = {
    enable = mkEnableOption "Enables yazi";
  };

  config = mkIf cfg.enable {
    programs.yazi = {
      enable = true;
      enableZshIntegration = true;
    };

    home.packages = with pkgs; [
      imagemagickBig
    ];
  };
}