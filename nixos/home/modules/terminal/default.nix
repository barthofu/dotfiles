{ homeModules
, lib
, ...
}:

let
  terminalHomeModules = "${homeModules}/terminal";
in {
  # Read all directories from homeModules
  imports = builtins.filter (module: lib.pathIsDirectory module) (
    map (module: "${terminalHomeModules}/${module}") (builtins.attrNames (builtins.readDir terminalHomeModules))
  );
}