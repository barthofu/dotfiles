{ pkgs, ... }:

{
    imports = [
        ./binds.nix
        ./settings.nix
    ];

    wayland.windowManager.hyprland = {
        enable = true;

        package = pkgs.hyprland;
        xwayland.enable = true;

        # plugins = with inputs.hyprland-plugins.packages.${pkgs.system}; [
        #     hyprbars
        #     hyprexpo
        # ];

        # systemd = {
        #     variables = ["--all"];
        #     extraCommands = [
        #         "systemctl --user stop graphical-session.target"
        #         "systemctl --user start hyprland-session.target"
        #     ];
        # };
    };
}