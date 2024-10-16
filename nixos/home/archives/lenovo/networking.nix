{ ... }: let
  hostname = "lenovo";
in {
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
  };
} 