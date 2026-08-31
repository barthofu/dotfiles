{ pkgs
, config
, ... 
}:

let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
  no-offload = pkgs.writeShellScriptBin "no-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=0
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=
    export __GLX_VENDOR_LIBRARY_NAME=
    export __VK_LAYER_NV_optimus=
    exec "$@"
  '';
in {
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    
    modesetting.enable = true;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;
    
    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = true;
    
    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    # Disabled: runtime suspend fails on driver 580.105.08 (nv_pmops_runtime_suspend
    # returns -5, GPU never reaches D3cold anyway) and correlates with shutdown hangs
    # ("nvidia-modeset: Error while waiting for GPU progress" looping, forcing a hard power-off).
    powerManagement.finegrained = false;

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

  environment.systemPackages = [
    nvidia-offload
    no-offload
  ];

  # powertop --auto-tune (module.power) sets power/control=auto on every PCI device,
  # including this GPU, even though finegrained runtime PM is disabled above. The kernel
  # then keeps attempting a runtime-suspend that the driver always fails (nv_pmops_runtime_suspend
  # returns -5), leaving the device stuck in runtime_status=error instead of active.
  # Force it back to "on" so the GPU never enters that broken retry state.
  services.udev.extraRules = ''
    SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{power/control}="on"
  '';

  # powertop.service runs After=multi-user.target, i.e. AFTER the udev rule above already
  # applied, and unconditionally resets power/control=auto on every PCI device again,
  # silently undoing the rule. Re-apply it once more, ordered after powertop.service, so
  # the GPU never ends up in the broken runtime-suspend retry loop that wedges nvidia-smi
  # ("Unable to determine the device handle ... Unknown Error") even without any real
  # suspend/resume cycle happening.
  systemd.services.nvidia-no-runtime-pm = {
    description = "Keep NVIDIA GPU power/control=on after powertop --auto-tune";
    after = [ "powertop.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.bash}/bin/bash -c 'echo on > /sys/bus/pci/devices/0000:01:00.0/power/control'";
    };
  };
}