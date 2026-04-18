{
  flakeRootPath,
  inputs,
  ...
}: let
  homePath = "/Users/eugenepark";
in {
  imports = [
    "${flakeRootPath}/modules/home-manager/nixvim"
    # "${flakeRootPath}/modules/home-manager/firefox.nix"
    "${flakeRootPath}/modules/home-manager/tmux.nix"
    "${flakeRootPath}/modules/home-manager/lazygit.nix"
    "${flakeRootPath}/modules/home-manager/zoxide.nix"
    "${flakeRootPath}/modules/home-manager/zsh.nix"
    "${flakeRootPath}/modules/home-manager/kitty.nix"
  ];

  config = {
    home = {
      username = "eugenepark";
      homeDirectory = homePath;
      stateVersion = "25.05";
    };
    programs.home-manager.enable = true;

    nixpkgs.config.allowUnfree = true;

    colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-hard;

    epark = {
      nixvim.enable = true;
      firefox.enable = true;
      lazygit.enable = true;
      tmux.enable = true;
      zoxide.enable = true;
      zsh.enable = true;
      kitty.enable = true;
    };
  };
}
