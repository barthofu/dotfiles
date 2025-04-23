{ inputs, ... }: 
final: _prev: let
  baseSettings = {
    config.allowBroken = true;
  };

  permittedInsecurePackages = [];

  unfreeSettings = {
    config = {
      inherit permittedInsecurePackages;
      allowUnfree = true;
    };
  };
in {
  stable = import inputs.stable { inherit (final) system; };
  stable-unfree = import inputs.stable { inherit (final) system; config = unfreeSettings.config; };

  unstable = import inputs.unstable { inherit (final) system; };
  unstable-unfree = import inputs.unstable { inherit (final) system; config = unfreeSettings.config; };

  master = import inputs.master { inherit (final) system; };
  master-unfree = import inputs.master { inherit (final) system; config = unfreeSettings.config; };
}
