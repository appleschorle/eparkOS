{flakeRootPath, ...}: {
  imports = [
    "${flakeRootPath}/modules/home-manager/terminal/zsh.nix"
  ];

  epark.terminal.zsh = {
    enable = true;
    cdpath = ["~/repos"];
    ignorePatterns = ["*TOKEN*"];

    sessionVariables = {};
    zshrc = builtins.readFile ./zsh/zshrc;
    zshenv = builtins.readFile ./zsh/zshenv;
    zlogin = builtins.readFile ./zsh/zlogin;
    zlogout = builtins.readFile ./zsh/zlogout;

    shellAliases = {};
    shellGlobalAliases = {};
  };
}
