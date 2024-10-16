{ pkgs, ... }:

{
    home.packages = with pkgs; [
        discord
        teams-for-linux
        telegram-desktop
        signal-desktop
    ];
}