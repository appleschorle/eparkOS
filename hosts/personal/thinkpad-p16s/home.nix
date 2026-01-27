{
  flakeRootPath,
  inputs,
  ...
}: let
  homePath = "/home/epark";
in {
  home = {
    username = "epark";
    homeDirectory = homePath;
    stateVersion = "25.05";
  };
  programs.home-manager.enable = true;

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

  nixpkgs.config.allowUnfree = true;

  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-hard;

  epark.nvim.enable = true;
  epark.hyprland.enable = true;
  epark.git.enable = true;
  epark.discord.enable = true;
  epark.firefox.enable = true;
  epark.cursor.enable = true;
  epark.chatgpt.enable = true;
  epark.dunst.enable = true;
  epark.icon-pack.enable = true;
  epark.lazygit.enable = true;
  epark.tmux.enable = true;
  epark.whatsapp.enable = true;
  epark.zoxide.enable = true;
  epark.zsh.enable = true;
}
