{ self
, pkgs
, lib
, config
, username
, ...
}:

with lib;

let
  cfg = config.module.users;
in {
  module.users = {
    enable = mkEnableOption "Enables users";
  };

  config = mkIf cfg.enable {
    users = {
      mutableUsers = true;

      groups = { 
        ${username} = {
          gid = 1000;
        };
      };

      users = {
        ${username} = {
          uid                = 1000;
          home               = "/home/${username}";
          group              = "${username}";
          createHome         = true;
          description        = "${username}";
          isNormalUser       = true;

          extraGroups = [
            "audio"
            "networkmanager"
            "wheel"
            "docker"
          ];
        };
      };
    };
  };
}
