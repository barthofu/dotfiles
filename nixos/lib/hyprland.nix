{ inputs, pkgs }:

let
  # Hyprland v0.56.2 requires glaze 7.x but nixpkgs ships 8.x.
  glaze7 = (pkgs.glaze.override {
    enableSSL = false;
    enableInterop = false;
  }).overrideAttrs (_: {
    version = "7.2.0";
    src = pkgs.fetchFromGitHub {
      owner = "stephenberry";
      repo = "glaze";
      tag = "v7.2.0";
      hash = "sha256-f3NVRi3SXKo42hn0WCw7JsOK3EkdOVJIcuzhPorKjFY=";
    };
  });
in
inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland.override {
  glaze-hyprland = glaze7;
  # NixOS' security wrapper rejects shell-script wrappers; v0.56.2 still uses makeWrapper.
  makeWrapper = pkgs.makeBinaryWrapper;
}
