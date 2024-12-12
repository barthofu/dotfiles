# ./host/common/global/optional/nfs.nix
{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
		nfs-utils
  ];

  services.autofs = {
		enable = true;

		autoMaster =
			let
				# intr param depricated in nfs4
				mapConf = pkgs.writeText "auto.mnt" ''
					nas -fstype=nfs4,rw,soft 172.20.10.10:/export
				'';
			in
				''
				/mnt ${mapConf}
				'';
  };
}
