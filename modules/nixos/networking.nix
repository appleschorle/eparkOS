{ lib, pkgs, config, ...}:

with lib;
{
	imports = [];
	
	options = {
		myNetwork = {
			hostName = mkOption {
				type = types.str;
				default = "my-laptop";
				example = "my-laptop";
				description = "Hostname of the device";
			};
		};
	};

	config = mkIf (config.myNetwork.hostName != null || config.myNetwork.hostName != "") {
		networking.hostName = config.myNetwork.hostName;
		networking.networkmanager.enable = true;
	};
}
