{ inputs, config, lib, ... }:

with lib;
{
	imports = [
		inputs.nixvim.homeModules.nixvim
	];

	options.myNvim.enable = mkEnableOption "Enable NeoVim";

	config = mkIf config.myNvim.enable {
		programs.nixvim = {
			enable = true;
			defaultEditor = true;
			viAlias = true;
			vimAlias = true;
			colorschemes.gruvbox-material-nvim.enable = true;
			plugins.lualine.enable = true;
		};	
	};
}
