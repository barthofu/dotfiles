{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    just
    libinput-gestures
    direnv
    docker-compose
  ];
}