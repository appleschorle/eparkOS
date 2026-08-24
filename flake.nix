{
  description = "eparkOS";

  # nixConfig = {
  #   substituters = [
  #     # status: https://mirror.sjtu.edu.cn/
  #     "https://mirror.sjtu.edu.cn/nix-channels/store"
  #
  #     # status: https://mirrors.tuna.tsinghua.edu.cn/
  #     "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
  #
  #     # status: https://mirrors.ustc.edu.cn/status/
  #     "https://mirrors.ustc.edu.cn/nix-channels/store"
  #   ];
  # };

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
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
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
          inputs.sops-nix.nixosModules.sops
          {
            sops.defaultSopsFile = ./secrets/secrets.yaml;
            sops.defaultSopsFormat = "yaml";
            sops.age.keyFile = "/home/epark/.config/sops/age/keys.txt";
            sops.secrets."homepage/google_calendar_api_url" = {};
          }
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
