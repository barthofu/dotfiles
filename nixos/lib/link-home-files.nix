/**
  * This lib file is obsolete but serves as an example on how to create custom functions for me.
  */

{ config
, pkgs
, lib
, ...
}:

let
  homeDir = "/home/${config.users.users.${config.users.mutableUsers.username}.name}";

  mkOutOfStoreSymlink = source: target: ''
    mkdir -p $(dirname ${target})
    ln -sf ${source} ${target}
  '';

  linkHomeFiles = args: let
    configPath = args.configPath;
    paths = args.paths;

    # Créer des symlinks pour chaque fichier dans les chemins spécifiés
    createSymlinks = builtins.concatMap (path: 
      let
        fullPath = "${configPath}/${path}";
        files = lib.filesystem.listFilesRecursive fullPath;
        
        # Tracer les fichiers trouvés dans chaque chemin
        _ = lib.trace "Found files in ${fullPath}: ${files}";

        # Création des symlinks pour chaque fichier
        symlinks = builtins.mapAttrs (_: file: let
          # Construire le nom basé sur le chemin relatif
          name = "${path}/${lib.path.removePrefix fullPath (/. + path) (/. + file)}";
        in
          {
            inherit name;  # On s'assure que `name` est utilisé correctement ici
            value = {
              source = "${file}";
              action = mkOutOfStoreSymlink "${file}" "${homeDir}/${name}";
            };
          }) files;
      in
        symlinks
    ) paths;
  in
    # Combiner tous les symlinks en un seul attribute set
    lib.attrsets.concatMapAttrs (_: symlinks: symlinks) createSymlinks;
  
in
{
  linkHomeFiles = linkHomeFiles;
}