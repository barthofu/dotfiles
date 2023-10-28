{ pkgs, ... }:

{
  users.users = {

    bartho = {
      isNormalUser = true;
      description = "bartho";
      # shell = pkgs.zsh;
      extraGroups = [
        "networkmanager"
        "docker"
        "wheel"
      ];
    };
  };
}