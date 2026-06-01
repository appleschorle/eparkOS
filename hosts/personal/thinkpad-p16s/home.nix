{
  flakeRootPath,
  inputs,
  ...
}: let
  homePath = "/home/epark";
in {
  imports = [
    "${flakeRootPath}/modules/home-manager/desktop/cursor.nix"
    "${flakeRootPath}/modules/home-manager/desktop/discord.nix"
    "${flakeRootPath}/modules/home-manager/desktop/dunst.nix"
    "${flakeRootPath}/modules/home-manager/desktop/hyprland"
    "${flakeRootPath}/modules/home-manager/desktop/icon-pack.nix"
    "${flakeRootPath}/modules/home-manager/development/direnv.nix"
    "${flakeRootPath}/modules/home-manager/development/lazygit.nix"
    "${flakeRootPath}/modules/home-manager/development/nixvim"
    "${flakeRootPath}/modules/home-manager/development/ruby.nix"
    "${flakeRootPath}/modules/home-manager/terminal/kitty.nix"
    "${flakeRootPath}/modules/home-manager/terminal/tmux"
    "${flakeRootPath}/modules/home-manager/terminal/xdg.nix"
    "${flakeRootPath}/modules/home-manager/terminal/zoxide.nix"
    ./home-manager/browser/firefox.nix
    ./home-manager/development/git.nix
    ./home-manager/terminal/zsh.nix
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
      development.nixvim.enable = true;
      desktop.hyprland.enable = true;
      desktop.discord.enable = true;
      desktop.cursor.enable = true;
      desktop.dunst.enable = true;
      desktop.icon-pack.enable = true;
      development.lazygit.enable = true;
      development.direnv.enable = true;
      development.ruby.enable = true;
      terminal.tmux.enable = true;
      terminal.zoxide.enable = true;
      terminal.kitty.enable = true;
      terminal.xdg.enable = true;
    };
  };
}
