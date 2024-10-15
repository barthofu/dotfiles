{ pkgs, config, ... }:

{
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot.supportedFilesystems = [ "ntfs" ];

  boot.initrd.luks.devices = {
    crypted = {
      device = "/dev/disk/by-uuid/dff927bd-4bb7-42db-9c20-250d28fe0865";
      preLVM = true;
      allowDiscards = true;
    };
  };

  boot.kernelParams = [ "processor.max_cstate=4" "amd_iomu=soft" "idle=nomwait"];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
}
