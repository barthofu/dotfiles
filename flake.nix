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
    ...
  } @ inputs: {

    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = [ ./configuration.nix ];
      };
    };
  };
}