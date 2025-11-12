{ lib
, config
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.graphics;
in {
  options.module.graphics = {
    enable = mkEnableOption "Enables graphics";
  };

  config = mkIf cfg.enable {
    nixpkgs.config.packageOverrides = pkgs: {
      intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
    };

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      package = pkgs.mesa;
      package32 = pkgs.pkgsi686Linux.mesa;
      extraPackages = with pkgs; [
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
        libvdpau-va-gl
        #mesa
        #mesa.drivers
        mesa-demos
      ];
    };

    # environment.variables = {
    #  GBM_BACKENDS_PATH = "/run/opengl-driver/lib";
    # };
  };
}
