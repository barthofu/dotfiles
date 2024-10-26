{ homeModules
, lib
, ...
}:

let
  binHomeModules = "${homeModules}/bin";
in {
  # Read all directories from homeModules
  imports = builtins.filter (module: lib.pathIsDirectory module) (
    map (module: "${binHomeModules}/${module}") (builtins.attrNames (builtins.readDir binHomeModules))
  );
}