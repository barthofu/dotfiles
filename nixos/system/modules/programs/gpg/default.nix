{ lib
, config
, inputs
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.programs.gpg;
in {
  options.module.programs.gpg = {
    enable = mkEnableOption "Enables gpg";
  };

  config = mkIf cfg.enable {
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = false;
      settings = {
        default-cache-ttl = 2592000;
        max-cache-ttl = 2592000;
      };    
    };
  };
}