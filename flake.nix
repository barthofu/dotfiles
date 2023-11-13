{
  description = "My NixOS config";

  nixConfig.substituters = [ "https://cache.nixos.org" ];

  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix.url = "github:nixos/nix";

    home-manager = {
      url = "github:nix-community/home-manager";
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
          ./default.nix
          
          # make home-manager as a module of nixos
          # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch --flake .#lenovo`
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.bartho = import ./home/bartho/lenovo;

            # optionally, use home-manager.extraSpecialArgs to pass arguments to home/bartho/lenovo/default.nix
          }
        ];
      };
    };
  };
}