{
  description = "Nix Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors.url = "github:misterio77/nix-colors";
  };

  # https://www.reddit.com/r/NixOS/comments/18eomkl/homemanager_as_nixos_module_or_as_standalone/
  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages."${system}".extend inputs.nur.overlays.default;
    personalPath = "${self}/hosts/personal/thinkpad-p16s";
    flakeRootPath = ./.;
  in {
    nixosConfigurations = {
      personal = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {inherit inputs flakeRootPath;};
        modules = [
          "${personalPath}/configuration.nix"
        ];
      };
    };

    homeConfigurations = {
      personal = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {inherit inputs flakeRootPath;};
        modules = [
          inputs.nix-colors.homeManagerModules.default
          "${personalPath}/home.nix"
        ];
      };
    };
  };
}
