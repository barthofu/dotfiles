{ ... }:

{
    time.hardwareClockInLocalTime = true;
    
    services.logrotate.checkConfig = false;
    services.printing.enable = true;

    environment.pathsToLink = [ "/libexec" ];

    console = {
        font = "Lat2-Terminus16";
        keyMap = "fr";
    };
}
