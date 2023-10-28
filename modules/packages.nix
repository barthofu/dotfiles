{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox
    git
    vim
    vscode
  ];
} 