{ ... }:

{
    services.xserver = {
        enable = true;
        videoDrivers = [ "nvidia" ];
        layout = "fr";
        xkbVariant = "azerty";
        displayManager = {
            gdm = {
                enable = true;
                wayland = true;
            };
        };
    }
}