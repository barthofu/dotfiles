{ pkgs, ... }:

{
    imports = [
        ./vscode.nix
        ./git.nix
    ];

    home.packages = with pkgs; [
        gitkraken
        jetbrains-toolbox
        # postman # TODO: not working, should install it using flatpak instead
        insomnia
        starship
        python3
    ];
}