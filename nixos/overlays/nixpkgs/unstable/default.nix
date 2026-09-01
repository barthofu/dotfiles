{ inputs
, ...
}:

{
  nixpkgs.overlays = [
    # Default unstable
    (final: _prev: {
      unstable = import inputs.unstable {
        system = final.stdenv.hostPlatform.system;
      };
    })

    # Unfree unstable
    (final: _prev: {
      unstable-unfree = import inputs.unstable {
        system = final.stdenv.hostPlatform.system;
        config.allowUnfree = true;
      };
    })
  ];
}