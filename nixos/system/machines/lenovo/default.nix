{ username, ... }:

{
	# Single flag to fully disable the discrete RTX 3050 in software (driver blacklisted,
	# Intel iGPU only) - flip to true to re-enable PRIME offload when needed (gaming/CUDA).
	machine.nvidiaDgpu.enable = false;

	module = {

		ai.enable = false;
		audio.enable = true;
		auto-updater.enable = true;
		battery.enable = true;
		bluetooth.enable = true;
		boot.enable = true;
		fonts.enable = true;
		graphics.enable = true;
		locale.enable = true;
		location.enable = true;
		misc.enable = true;
		network.enable = true;
		power.enable = true;
		security.enable = true;
		stylix.enable = true;
		touchpad.enable = true;
		users.enable = true;
		variables.enable = true;
		packages.enable = true;
		virtualisation = {
			enable = true;
			usePodman = true;
		};
		
		services = {
			greetd.enable = true;
			tailscale.enable = true;
			dbus.enable = true;
			polkit.enable = true;
			openvpn.enable = true;
			logind.enable = true;
			flatpak.enable = true;
			
			acpid.enable = false;
		};

		programs = {
			adb.enable = true;
			hm.enable = true;
			xdg-portal.enable = true;
			hyprland.enable = true;
			thunar.enable = true;
			nix-ld.enable = true;
			dconf.enable = true;
			obs-studio.enable = true;
		};
	};
}