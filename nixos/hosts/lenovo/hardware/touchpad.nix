{ ... }:

{
  services.xserver.libinput = {
    enable = true;
    touchpad = {
      tapping = true;
      naturalScrolling = false;
      scrollMethod = "twofinger";
      disableWhileTyping = false;
    };
  };
}
