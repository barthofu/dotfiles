{
  systems = ["x86_64-linux"];

  perSystem = {pkgs, ...}: {
    packages = {
      cliphist-wofi-img = pkgs.callPackage ./cliphist-wofi-img {};
    };
  };
}