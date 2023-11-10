{ pkgs, ... }:

{

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    # firefox
    # vim
    # vscode
  ];
} 