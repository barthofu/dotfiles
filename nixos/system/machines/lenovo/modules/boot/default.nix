{ config
, pkgs
, ...
}:

{

  boot = {


    supportedFilesystems = [ "ntfs" ];

    initrd.luks.devices = {
      crypted = {
        device = "/dev/disk/by-uuid/dff927bd-4bb7-42db-9c20-250d28fe0865";
        preLVM = true;
        allowDiscards = true;
      };
    };

    kernelParams = [ "processor.max_cstate=4" "amd_iomu=soft" "idle=nomwait"];
    kernelPackages = pkgs.linuxPackages_latest;
    extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
    extraModprobeConfig = ''
      options kvm_intel nested=1
      options kvm_intel emulate_invalid_guest_state=0
      options kvm ignore_msrs=1
    '';
  };
  
}