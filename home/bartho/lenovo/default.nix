{ config, pkgs, inputs, ... }:

{
    imports = [
        ../shared
        ./programs
        ./packages.nix
    ];
}