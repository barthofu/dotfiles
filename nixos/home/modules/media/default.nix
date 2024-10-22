{ homeModules
, lib
, ...
}:

let
  mediaHomeModules = "${homeModules}/media";
in {
  # Read all directories from homeModules
  imports = builtins.filter (module: lib.pathIsDirectory module) (
    map (module: "${mediaHomeModules}/${module}") (builtins.attrNames (builtins.readDir mediaHomeModules))
  );
}