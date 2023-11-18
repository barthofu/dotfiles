{ pkgs, ... }:

{
  networking = {
    hostName = "lenovo";
    networkmanager.enable = true;
  };
} 