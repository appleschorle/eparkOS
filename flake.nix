{
  description = "eparkOS";

  nixConfig = {
    substituters = [
      # status: https://mirror.sjtu.edu.cn/
      "https://mirror.sjtu.edu.cn/nix-channels/store"

      # status: https://mirrors.tuna.tsinghua.edu.cn/
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"

      # status: https://mirrors.ustc.edu.cn/status/
      "https://mirrors.ustc.edu.cn/nix-channels/store"
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors.url = "github:misterio77/nix-colors";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-dots = {
      url = "git+ssh://git@github.com/appleschorle/hyprland-dots.git?shallow=1";
      flake = false;
    };
    waybar-dots = {
      url = "git+ssh://git@github.com/appleschorle/waybar-dots.git?shallow=1";
      flake = false;
    };
  };

  outputs = {nixpkgs, ...} @ inputs: {
    nixosConfigurations = {
      personal = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};

        modules = [
          ./hosts/personal
          inputs.home-manager.nixosModules.home-manager
          {nixpkgs.overlays = [inputs.nur.overlays.default];}
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {inherit inputs;};
            home-manager.users.epark = ./users/epark;
            home-manager.backupFileExtension = "backup";
          }
        ];
      };
    };
  };
}
