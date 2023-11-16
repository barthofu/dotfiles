{ pkgs, ... }:

{
  nix = {
    package = pkgs.nixFlakes;

    settings.experimental-features = [ "nix-command" "flakes" "repl-flake" ];
    
    substituters = [
      "https://cache.nixos.org"
    ];

    # optimisation
    optimise.automatic = true;
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    # automatically run garbage collection whenever there is not enough space left.
    # free up to 1GiB whenever there is less than 100MiB left.
    extraOptions = ''
      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
    '';
  };
}