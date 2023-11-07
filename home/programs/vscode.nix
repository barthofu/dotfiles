{
    configs,
    pkgs,
    ...
}: let
in {
    programs.vscode = {
        enable = true;
        package = pkgs.vscodium;
    }
}