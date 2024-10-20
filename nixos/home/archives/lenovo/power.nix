{ config, ... }:

{    
	services = {
		power-profiles-daemon.enable = !config.services.tlp.enable;
		thermald.enable = true;
		tlp = {
			enable = true;
			settings = {
				# Platform
				PLATFORM_PROFILE_ON_BAT = "powersave";
				PLATFORM_PROFILE_ON_AC = "perfomance";
						
				# Processor
				CPU_SCALING_MAX_FREQ_ON_AC = 3200000;
				CPU_BOOST_ON_BAT = 0;
				CPU_BOOST_ON_AC = 1;
				CPU_HWP_DYN_BOOST_ON_BAT = 0;
				CPU_HWP_DYN_BOOST_ON_AC = 1;
			};
		};
	};
	powerManagement.powertop.enable = true;
}
