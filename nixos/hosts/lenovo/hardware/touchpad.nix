{ ... }:

{
  services.xserver.libinput = {
    enable = true;
    touchpad = {
      tapping = true;
      naturalScrolling = false;
      scrollMethod = "twofingers";
      disableWhileTyping = false;
    };
  };
}