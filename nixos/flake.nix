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
    # Between nixpkgs-unstable and master is about 3 days and a binary cache And then like 1-2 more days till nixos-unstable
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nix.url = "github:nixos/nix";

    # Home Manager is a Nix-powered tool for reproducible management of the contents of users’ home directories
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

  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: {

    nixosConfigurations = {
      lenovo = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = [ 

          ./hosts/lenovo
          ./hosts/shared
          
          # make home-manager as a module of nixos
          # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch --flake .#lenovo`
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.bartho = {
              imports = [
                ./home/bartho/lenovo
              ];
            };

            # optionally, use home-manager.extraSpecialArgs to pass arguments to home/bartho/lenovo/default.nix
          }
        ];
      };
    };
  };
}