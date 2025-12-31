{
  flakeRootPath,
  pkgs,
  ...
}: {
  home = {
    username = "epark";
    homeDirectory = "/home/epark";
    stateVersion = "25.05";
  };
  programs.home-manager.enable = true;

  imports = [
    "${flakeRootPath}/modules/home-manager/nvim"
    "${flakeRootPath}/modules/home-manager/hyprland"

    "${flakeRootPath}/modules/home-manager/git.nix"
    "${flakeRootPath}/modules/home-manager/discord.nix"
    "${flakeRootPath}/modules/home-manager/firefox.nix"
  ];

  nixpkgs.config.allowUnfree = true;

  epark.nvim.enable = true;
  epark.hyprland.enable = true;
  epark.git.enable = true;
  epark.discord.enable = true;
  epark.firefox.enable = true;

  # fonts.fontconfig.enable = true;
  #
  # home.packages = with pkgs; [
  #   nerdfonts.fira-code
  #   nerdfonts.fira-code-symbols
  # ];
}
