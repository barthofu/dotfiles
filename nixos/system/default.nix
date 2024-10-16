{ lib
, inputs
, self
, commonModules
, systemModules
, machineConfigurationPath
, machineConfigurationPathExist
, machineModulesPath
, machineModulesPathExist
, username
, platform ? null
, stateVersion ? null
, ...
}:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.impermanence.nixosModules.impermanence

    "${commonModules}"
    "${systemModules}"
    "${self}/overlays/nixpkgs"
  ]
  ++ lib.optional machineConfigurationPathExist machineConfigurationPath
  ++ lib.optional machineModulesPathExist machineModulesPath;

  module.nix-config.enable = true;

  # System version
  system = { inherit stateVersion; };

  # HostPlatform
  nixpkgs = {
    hostPlatform = platform;
  };
}
