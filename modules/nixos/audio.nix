{ config, lib, ... }:

with lib;
{
	options.myAudio.enable = mkEnableOption "System Audio";

	config = mkIf config.myAudio.enable {
		services.pipewire = {
			enable = true;
			pulse.enable = true;
		};
	};
}
