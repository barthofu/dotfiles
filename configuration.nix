{ home-manager, pkgs, ... }: {

  imports = [ 
    # include the results of the hardware scan
    ./hardware-configuration.nix

    # home-manager
    home-manager.nixosModules.home-manager
    
    # local
    ./home/home.nix
    ./modules
    ./overlays
    ./derivations
    ./packages
  ];

  system.stateVersion = "23.05";
}