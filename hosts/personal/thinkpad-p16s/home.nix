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

  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-hard;

  imports = [
    "${flakeRootPath}/modules/home-manager/nvim"
    "${flakeRootPath}/modules/home-manager/hyprland"
    "${flakeRootPath}/modules/home-manager/git.nix"
    "${flakeRootPath}/modules/home-manager/discord.nix"
    "${flakeRootPath}/modules/home-manager/firefox.nix"
    "${flakeRootPath}/modules/home-manager/cursor.nix"
    "${flakeRootPath}/modules/home-manager/tmux.nix"
    "${flakeRootPath}/modules/home-manager/lazygit.nix"
    "${flakeRootPath}/modules/home-manager/zoxide.nix"
  ];

  nixpkgs.config.allowUnfree = true;

  epark.nvim.enable = true;
  epark.hyprland.enable = true;
  epark.git.enable = true;
  epark.discord.enable = true;
  epark.firefox.enable = true;

  programs.kitty = {
    enable = true;
    themeFile = "GruvboxMaterialDarkHard";
    font = {
      name = "FiraCode Nerd Font";
      size = 14;
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    autocd = true;
    autosuggestion = {
      enable = true;
    };
    defaultKeymap = "viins";
    dirHashes = {
      repos = "homePath/repos";
    };
    history = {
      append = true;
      expireDuplicatesFirst = true;
      extended = true;
      findNoDups = true;
    };
    historySubstringSearch = {
      enable = true;
    };
    shellAliases = {
      ll = "ls -l";
    };
    shellGlobalAliases = {
      G = "| grep";
    };
    siteFunctions = {
      mkcd = ''
        mkdir --parents "$1" && cd "$1"
      '';
    };
    syntaxHighlighting = {
      enable = true;
      highlighters = [
        "main"
        "brackets"
        "root"
        "cursor"
      ];
    };
    sessionVariables = {
      EDITOR = "vi";
    };
  };
}
