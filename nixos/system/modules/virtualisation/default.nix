{ lib
, config
, pkgs
, username
, ...
}:

with lib;

let
  cfg = config.module.virtualisation;
in {
  options.module.virtualisation = {
    enable = mkEnableOption "Enables virtualisation";
    usePodman = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Use podman instead of docker.
      '';
    };
  };

  config = mkIf cfg.enable {
    virtualisation = {
      docker = {
        enable = !cfg.usePodman;
        enableOnBoot = true;
        rootless = {
          enable = true;
          setSocketVariable = true;
        };
      };

      podman = {
        enable = cfg.usePodman;
        dockerCompat = true; # create a `docker` alias for podman, to use it as a drop-in replacement
        defaultNetwork.settings.dns_enabled = true; # required for containers under podman-compose to be able to talk to each other
      };

      libvirtd.enable = true;
    };

    users.users.${username}.extraGroups = [ "libvirt" "docker" ];

    environment.systemPackages = with pkgs; [
      distrobox
      qemu
    ] ++ (if cfg.usePodman then [ 
      podman-compose 
      podman-tui
    ] else [
      lazydocker
      docker-credential-helpers
    ]);
  };
}