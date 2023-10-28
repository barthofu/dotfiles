{ ... }:

{
  networking = {
    hostName = "nixos";
    networking.networkmanager.enable = true;
    # useDHCP = false;
    # interfaces.enp0s3.useDHCP = true;
  };
} 