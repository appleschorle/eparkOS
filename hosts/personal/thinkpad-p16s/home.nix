{
  flakeRootPath,
  inputs,
  ...
}: let
  homePath = "/home/epark";
in {
  imports = [
    ./home-manager/browser/firefox.nix
    ./home-manager/terminal/zsh.nix
    ./home-manager/development/git.nix
    "${flakeRootPath}/modules/home-manager/terminal/kitty.nix"
    "${flakeRootPath}/modules/home-manager/terminal/tmux"
    "${flakeRootPath}/modules/home-manager/terminal/xdg.nix"
    "${flakeRootPath}/modules/home-manager/terminal/zoxide.nix"
    "${flakeRootPath}/modules/home-manager/development/lazygit.nix"
    "${flakeRootPath}/modules/home-manager/development/ruby.nix"
    "${flakeRootPath}/modules/home-manager/development/direnv.nix"
    "${flakeRootPath}/modules/home-manager/desktop/discord.nix"
    "${flakeRootPath}/modules/home-manager/desktop/cursor.nix"
    "${flakeRootPath}/modules/home-manager/desktop/icon-pack.nix"
    "${flakeRootPath}/modules/home-manager/desktop/dunst.nix"
    "${flakeRootPath}/modules/home-manager/nixvim"
    "${flakeRootPath}/modules/home-manager/hyprland"
  ];

  config = {
    home = {
      username = "epark";
      homeDirectory = homePath;
      stateVersion = "25.05";
    };
    programs.home-manager.enable = true;

    nixpkgs.config.allowUnfree = true;

    colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-hard;

    epark = {
      nixvim.enable = true;
      hyprland.enable = true;
      discord.enable = true;
      cursor.enable = true;
      dunst.enable = true;
      icon-pack.enable = true;
      lazygit.enable = true;
      tmux.enable = true;
      zoxide.enable = true;
      xdg.enable = true;
      kitty.enable = true;
      ruby.enable = true;
      direnv.enable = true;
    };
  };
}
