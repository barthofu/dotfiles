{ inputs
, ...
}:

{
  nixpkgs.overlays = [
    # Default master
    (final: _prev: {
      master = import inputs.master {
        system = final.stdenv.hostPlatform.system;
      };
    })

    # Unfree master
    (final: _prev: {
      master-unfree = import inputs.master {
        system = final.stdenv.hostPlatform.system;
        config.allowUnfree = true;
      };
    })
  ];
}
