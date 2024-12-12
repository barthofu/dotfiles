# ./host/common/global/optional/nfs.nix
{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
		nfs-utils
  ];

  fileSystems."/mnt/nas" = {
		device = "172.20.10.100:/";
		fsType = "nfs";
		options = [
			"nfsvers=4.2" 
			"x-systemd.automount" 
			"noauto" 
		];
	};
}
