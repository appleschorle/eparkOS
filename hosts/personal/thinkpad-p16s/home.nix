{flakeRootPath, ...}: let
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
  ];

  nixpkgs.config.allowUnfree = true;

  epark.nvim.enable = true;
  epark.hyprland.enable = true;
  epark.git.enable = true;
  epark.discord.enable = true;
  epark.firefox.enable = true;

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
      EDITOR = "vim";
    };
  };

  # fonts.fontconfig.enable = true;
  #
  # home.packages = with pkgs; [
  #   nerdfonts.fira-code
  #   nerdfonts.fira-code-symbols
  # ];
}
