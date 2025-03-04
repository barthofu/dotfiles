{ self
, pkgs
, inputs
, lib
, hostname
, username
, platform
, stateVersion
, homeModules
, commonModules
, isWorkstation ? false
, wm ? ""
, swayEnable ? false
, hyprlandEnable ? false
, wmEnable ? false
, ...
}:

let
  inherit (pkgs.stdenv) isLinux;

  isRoot                     = username == "root";
  homeDirectory              = if isRoot then "/root" else "/home/${username}";
  userConfigurationPath      = "${self}/home/users/${username}";
  userConfigurationPathExist = builtins.pathExists userConfigurationPath;
  userModulesPath            = "${self}/home/users/${username}/modules";
  userModulesPathExist       = builtins.pathExists userModulesPath;
  sshModulePath              = "${homeModules}/ssh";
  sshModuleExistPath         = builtins.pathExists sshModulePath;
in {
  home-manager = {
    useGlobalPkgs   = true;
    useUserPackages = true;
    backupFileExtension = "backup-" + pkgs.lib.readFile "${pkgs.runCommand "timestamp" {} "echo -n `date '+%Y%m%d%H%M%S'` > $out"}";

    extraSpecialArgs = {
      inherit 
        inputs 
        self 
        hostname 
        username 
        homeDirectory
        platform 
        stateVersion 
        isLinux 
        commonModules 
        homeModules 
        isWorkstation
        wm 
        hyprlandEnable 
        wmEnable;
      pkgs-stable = import inputs.stable {
        system = platform;
        config.allowUnfree = true;
      };
      pkgs-master = import inputs.master {
        system = platform;
        config.allowUnfree = true;
      };
    };

    users.${username} = {

      imports = [
        inputs.impermanence.nixosModules.home-manager.impermanence

        "${commonModules}"
        "${homeModules}"
      ] ++ lib.optional sshModuleExistPath         sshModulePath
        ++ lib.optional userConfigurationPathExist userConfigurationPath
        ++ lib.optional userModulesPathExist       userModulesPath;

      home = {
        inherit username;
        inherit stateVersion;
        inherit homeDirectory;
      };
    };
  };
}
