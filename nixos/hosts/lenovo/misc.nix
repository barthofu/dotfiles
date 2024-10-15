{ ... }:

{
    time.hardwareClockInLocalTime = true;
    services.logrotate.checkConfig = false;
    services.printing.enable = true;

    console = {
        font = "Lat2-Terminus16";
        keyMap = "fr";
    };
}
