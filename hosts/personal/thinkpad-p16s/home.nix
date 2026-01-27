{
  flakeRootPath,
  inputs,
  ...
}: let
  homePath = "/home/epark";
in {
  imports = [
    "${flakeRootPath}/modules/home-manager/nvim"
    "${flakeRootPath}/modules/home-manager/hyprland"
    "${flakeRootPath}/modules/home-manager/git.nix"
    "${flakeRootPath}/modules/home-manager/discord.nix"
    "${flakeRootPath}/modules/home-manager/firefox.nix"
    "${flakeRootPath}/modules/home-manager/cursor.nix"
    "${flakeRootPath}/modules/home-manager/tmux.nix"
    "${flakeRootPath}/modules/home-manager/lazygit.nix"
    "${flakeRootPath}/modules/home-manager/whatsapp.nix"
    "${flakeRootPath}/modules/home-manager/chatgpt.nix"
    "${flakeRootPath}/modules/home-manager/zoxide.nix"
    "${flakeRootPath}/modules/home-manager/zsh.nix"
    "${flakeRootPath}/modules/home-manager/icon-pack.nix"
    "${flakeRootPath}/modules/home-manager/dunst.nix"
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
      nvim.enable = true;
      hyprland.enable = true;
      git.enable = true;
      discord.enable = true;
      firefox.enable = true;
      cursor.enable = true;
      chatgpt.enable = true;
      dunst.enable = true;
      icon-pack.enable = true;
      lazygit.enable = true;
      tmux.enable = true;
      whatsapp.enable = true;
      zoxide.enable = true;
      zsh.enable = true;
    };
  };
}
