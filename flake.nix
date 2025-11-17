{
	description = "Nix Configuration";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
		home-manager.url = "github:nix-community/home-manager/release-25.05";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
	};

	# https://www.reddit.com/r/NixOS/comments/18eomkl/homemanager_as_nixos_module_or_as_standalone/
	outputs = { nixpkgs, home-manager, ... } @ inputs: {
		nixosConfigurations = {
			personal = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				modules = [
					./hosts/personal/thinkpad-p16s/configuration.nix
					home-manager.nixosModules.home-manager {
						home-manager.useGlobalPkgs = true;
						home-manager.users.epark = import ./hosts/personal/thinkpad-p16s/home.nix;
					}
				];
				specialArgs = { inherit inputs; };
			};
		};
	};
}
