{ homeModules
, lib
, ...
}:

let
  utilsHomeModules = "${homeModules}/utils";
in {
  # Read all directories from homeModules
  imports = builtins.filter (module: lib.pathIsDirectory module) (
    map (module: "${utilsHomeModules}/${module}") (builtins.attrNames (builtins.readDir utilsHomeModules))
  );
}