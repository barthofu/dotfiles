{ pkgs, config, ... }:

{
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot.supportedFilesystems = [ "ntfs" ];

  boot.initrd.luks.devices = {
    crypted = {
      device = "/dev/disk/by-uuid/5b21bd1e-cda0-423e-b4a4-2f605a568265";
      preLVM = true;
      allowDiscards = true;
    };
  };

  boot.kernelParams = [ "processor.max_cstate=4" "amd_iomu=soft" "idle=nomwait"];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
}
