{ username, ... }:

{
	imports = [
		./hardware-configuration.nix
		./nvidia.nix
	];

	module = {

		audio.enable = true;
		bluetooth.enable = true;
		boot.enable = true;
		graphics.enable = true;
		locale.enable = true;
		misc.enable = true;
		network.enable = true;
		power.enable = true;
		security.enable = true;
		touchpad.enable = true;
		users.enable = true;
		variables.enable = true;
		virtualization.enable = true;

		services = {
			greetd.enable = true;
		};

		programs = {
			hm.enable = true;
		};
	};
}