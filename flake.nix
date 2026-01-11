{
  description = "Nix Configuration";
  # TODO: Different languages for keyboard, rofi ricing (perhaps also a window picker),
  # dunst notifications, better exponential sound and brightness see eric murphy,
  # specific workspaces (AI, Browser, Terminal), AI integration in nvim and terminal,
  # Nvim global paste on visual mode, keyboard binding utility app to see all keyboard bindings in one go,
  # remap caps lock, refactoring to have a common colorscheme and fonts as inputs and be able to enable disable certain features, macos integration.
  # Perhaps check better language defaults in nvim for indentation etc.
  # Customize browser more with certain start pages and also with custom search engines for nixos or others etc.

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
    sysc-greet = {
      url = "github:Nomadcxx/sysc-greet";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
          inputs.sysc-greet.nixosModules.default
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
