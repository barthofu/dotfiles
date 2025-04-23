{ inputs, ... }:

{
  nixpkgs.overlays = [
    (import ./nixpkgs.nix { inherit inputs; })
    (import ./custom-pkgs.nix)
  ];
}
