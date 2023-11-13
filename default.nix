{ home-manager, pkgs, ... }: {

  imports = [ 
    # include the results of the hardware scan
    ./hosts/lenovo/hardware-configuration.nix # TODO: make this dynamic based on hostname provided in the flake's nixos config

    # home-manager
    home-manager.nixosModules.home-manager
    
    # local
    ./core
  ];

  system.stateVersion = "23.05";
}