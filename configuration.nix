{ home-manager, pkgs, ... }: {

  imports = [ 
    # include the results of the hardware scan
    ./hardware-configuration.nix

    # home-manager
    home-manager.nixosModules.home-manager
    
    # local
    ./modules
    ./overlays
    ./derivations
    ./packages
  ];

  system.stateVersion = "23.05";
}