{ config, ... }:

{
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.stable;
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
        nvidiaSettings = true;
        open = false;

        prime = {
        offload = {
            enable = true;
            enableOffloadCmd = true;
        };

        # Make sure to use the correct Bus ID values for your system!
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
        };
    };
}