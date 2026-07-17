{
  description = "eparkOS — shared NixOS and home-manager modules";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, ...} @ inputs: {
    homeManagerModules = {
      # All modules in one import
      default = import ./modules/home-manager {inherit inputs;};

      # Individual modules
      browser.firefox = ./modules/home-manager/browser/firefox.nix;

      desktop.cursor = ./modules/home-manager/desktop/cursor.nix;
      desktop.discord = ./modules/home-manager/desktop/discord.nix;
      desktop.dunst = ./modules/home-manager/desktop/dunst.nix;
      desktop.hyprland = ./modules/home-manager/desktop/hyprland;
      desktop.icon-pack = ./modules/home-manager/desktop/icon-pack.nix;

      development.direnv = ./modules/home-manager/development/direnv.nix;
      development.git = ./modules/home-manager/development/git.nix;
      development.lazygit = ./modules/home-manager/development/lazygit.nix;
      development.nixvim = {
        imports = [
          ./modules/home-manager/development/nixvim
          inputs.nixvim.homeModules.nixvim
        ];
      };
      development.ruby = ./modules/home-manager/development/ruby.nix;

      terminal.kitty = ./modules/home-manager/terminal/kitty.nix;
      terminal.tmux = ./modules/home-manager/terminal/tmux;
      terminal.xdg = ./modules/home-manager/terminal/xdg.nix;
      terminal.zoxide = ./modules/home-manager/terminal/zoxide.nix;
      terminal.zsh = ./modules/home-manager/terminal/zsh.nix;
    };

    nixosModules = {
      tuigreet = ./modules/nixos/tuigreet.nix;
      media = ./modules/nixos/media.nix;
    };
  };
}
