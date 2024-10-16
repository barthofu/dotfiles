{ self
, inputs
, ...
}:

let
  homeConfiguration   = "${self}/home";
  systemConfiguration = "${self}/system";

  homeModules         = "${homeConfiguration}/modules";
  systemModules       = "${systemConfiguration}/modules";
  commonModules       = "${self}/modules";

  # Helper function for generating host configs
  mkHost = machineDir:
    { username ? "user"
    , stateVersion ? "24.05"
    , platform ? "x86_64-linux" 
    , hostname ? machineDir
    , isWorkstation ? false
    , wm ? null
    }:
    let
      machineConfigurationPath      = "${self}/system/machines/${machineDir}";
      machineConfigurationPathExist = builtins.pathExists machineConfigurationPath;
      machineModulesPath            = "${self}/system/machines/${machineDir}/modules";
      machineModulesPathExist       = builtins.pathExists machineModulesPath;

      hyprlandEnable = wm == "hyprland";
      wmEnable       = hyprlandEnable;
    in inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit 
          inputs
          self
          hostname
          username
          stateVersion
          platform
          machineDir
          isWorkstation
          wm
          homeModules
          commonModules
          systemModules
          machineConfigurationPath
          machineConfigurationPathExist
          machineModulesPath
          machineModulesPathExist
          hyprlandEnable
          wmEnable;
      };

      modules = [
        "${systemConfiguration}"
        "${homeConfiguration}"
      ];
    };

in {
  forAllSystems = inputs.nixpkgs.lib.systems.flakeExposed;

  # This function just add mkHost before hosts attrset
  # ex: pcbox = { username = "test"; stateVersion = "24.11"; }; ->
  # pcbox = mkHost { username = "test"; stateVersion = "24.11"; };
  genNixos  = builtins.mapAttrs mkHost;
}