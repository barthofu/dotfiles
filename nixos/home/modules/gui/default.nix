{ homeModules
, lib
, ...
}:

let
  guiHomeModules = "${homeModules}/gui";
in {
  # Read all directories from homeModules
  imports = builtins.filter (module: lib.pathIsDirectory module) (
    map (module: "${guiHomeModules}/${module}") (builtins.attrNames (builtins.readDir guiHomeModules))
  );
}