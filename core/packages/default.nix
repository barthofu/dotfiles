{ pkgs, ... }:

{

  imports = [
    ./docker.nix
  ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    just
    # firefox
    # vim
    # vscode
  ];
} 