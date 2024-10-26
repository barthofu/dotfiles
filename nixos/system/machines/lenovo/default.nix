{ username, ... }:

{
	module = {

		audio.enable = true;
		battery.enable = true;
		bluetooth.enable = true;
		boot.enable = true;
		fonts.enable = true;
		graphics.enable = true;
		locale.enable = true;
		misc.enable = true;
		network.enable = true;
		security.enable = true;
		touchpad.enable = true;
		users.enable = true;
		variables.enable = true;
		packages.enable = true;
		virtualisation = {
			enable = true;
			usePodman = true;
		};
		location.enable = true;
		ai.enable = false;
		auto-updater.enable = true;
		
		services = {
			greetd.enable = true;
			gnome.enable = true;
		};

		programs = {
			hm.enable = true;
			xdg-portal.enable = true;
			hyprland.enable = true;
			thunar.enable = true;
		};
	};
}