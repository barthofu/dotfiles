{ pkgs, ... }:

{
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3Support = true;
      alsaSupport = true;
      pulseSupport = true;
      nlSupport = false;
      iwSupport = true;
      mpdSupport = true;
      githubSupport = true;
    };
    script = ''
      for m in $(polybar --list-monitors | ${pkgs.coreutils-full}/bin/cut -d":" -f1); do
          MONITOR=$m polybar --reload top &
      done
    '';
  };
}