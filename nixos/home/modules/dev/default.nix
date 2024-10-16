{ homeModules
, lib
, ...
}:

let
  devHomeModules = "${homeModules}/dev";
in {
  # Read all directories from homeModules
  imports = builtins.filter (module: lib.pathIsDirectory module) (
    map (module: "${devHomeModules}/${module}") (builtins.attrNames (builtins.readDir devHomeModules))
  );
}