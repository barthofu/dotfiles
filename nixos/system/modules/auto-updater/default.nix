{ lib
, config
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.auto-updater;
in {
  options.module.auto-updater = {
    enable = mkEnableOption "Enables auto-updater";
  };

  config = mkIf cfg.enable {

    # Scheduled auto upgrade system (this is only for system upgrades, 
    # if you want to upgrade cargo\npm\pip global packages, docker containers or different part of the system 
    # or get really full system upgrade, use `topgrade` CLI utility manually instead.
    # I recommend running `topgrade` once a week or at least once a month)
    system.autoUpgrade = {
      enable = true;
      operation = "switch"; # If you don't want to apply updates immediately, only after rebooting, use `boot` option in this case
      flake = "/etc/nixos";
      dates = "weekly";
    };
  };
}