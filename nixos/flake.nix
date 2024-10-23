{
  description = "Bartho | NixOs Configuration";

  # the nixConfig here only affects the flake itself, not the system configuration!
  nixConfig.substituters = [ "https://cache.nixos.org" ];

  /*
  * Inputs is an attribute set that defines all the dependencies of this flake.
  * These dependencies will be passed as arguments to the outputs function after they are fetched
  * Inputs can be :- another flake, a regular Git repository, or a local path
  */
  inputs = {

    ####################  Core Repositories ####################
    # Official NixOS repo
    master = {
      url = "github:NixOS/nixpkgs/master";
    };

    unstable = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    # Latest stable
    stable = {
      url = "github:NixOS/nixpkgs/nixos-24.05";
    };

    # Current nixpkgs branch
    nixpkgs = {
      follows = "unstable";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ####################  Desktop Environments & WindowManager | remote flake ####################
    # Hyprland is a collection of NixOS modules and packages for a more modern and minimal desktop experience. with plugins for home-manager.
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    hyprland-virtual-desktops = {
      url = "https://github.com/levnikmyskin/hyprland-virtual-desktops/archive/refs/tags/v2.2.4.tar.gz";
      inputs.hyprland.follows = "hyprland";
    };
    # hyprland-plugins = {
    #   url = "github:hyprwm/hyprland-plugins";
    #   inputs.hyprland.follows = "hyprland";
    # };

    ####################  Community & Other Repositories | remote flake ####################
    # Firefox-addons is a collection of Firefox extensions
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-index is a tool to quickly locate the package providing a certain file in nixpkgs. It indexes built derivations found in binary caches.
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:/nix-community/impermanence";
    };

    xdghypr = {
      url = "github:hyprwm/xdg-desktop-portal-hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = {
    self,
    flake-parts,
    ...
  } @ inputs:
  let
    # Description of hosts
    hosts = import ./hosts.nix;
    # Import helper functions
    genNixosLib = import ./lib/gen-nixos.nix { inherit self inputs; };
  in flake-parts.lib.mkFlake { inherit inputs; } {
    
    systems = genNixosLib.forAllSystems;

    flake = {
      nixosConfigurations = genNixosLib.genNixos hosts.nixos;
    };
  };
}