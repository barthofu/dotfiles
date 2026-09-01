{ inputs
, ...
}:

{
  nixpkgs.overlays = [
    # Default stable
    (final: _prev: {
      stable = import inputs.stable {
        system = final.stdenv.hostPlatform.system;
      };
    })

    # Unfree stable
    (final: _prev: {
      stable-unfree = import inputs.stable {
        system = final.stdenv.hostPlatform.system;
        config.allowUnfree = true;
      };
    })
  ];
}