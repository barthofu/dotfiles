{
  imports = [
    ./packages
    ./derivations
    ./overlays

    ./home-manager.nix
    ./networking.nix
    ./nix.nix
    ./services.nix
    ./virtualization.nix
    ./boot.nix
    ./locale.nix
    ./users.nix
    ./fonts.nix
    ./console.nix
    ./sound.nix
    # ./stylix.nix
  ];
}