{ config
, pkgs
, lib
, ... 
}:

let
  ln = config.lib.file.mkOutOfStoreSymlink;
  lndir = path: link: builtins.listToAttrs (
    map (file: {
      name = "${link}/${lib.path.removePrefix (/. + path) (/. + file)}";
      value = { source = ln "${file}"; };
    }) (lib.filesystem.listFilesRecursive path)
  );
  rmopts = attrs: builtins.removeAttrs attrs ["source" "recursive" "outOfStoreSymlink"];
in
{
  linkHomeFiles = fileAttrs: lib.attrsets.concatMapAttrs (name: value:
    if value.outOfStoreSymlink or false
    then
      if value.recursive or false
      then
        lib.attrsets.mapAttrs (_: attrs: attrs // rmopts value) (lndir value.source name)
      else
        { "${name}" = { source = ln value.source; } // rmopts value; }
    else
      { "${name}" = value; }
  ) fileAttrs;
}