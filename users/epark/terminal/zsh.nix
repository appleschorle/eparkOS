{...}: {
  epark.terminal.zsh = {
    enable = true;
    cdpath = ["~/repos"];
    ignorePatterns = ["*TOKEN*"];
    zshrc = builtins.readFile ./zsh/zshrc;
    zshenv = builtins.readFile ./zsh/zshenv;
    zlogin = builtins.readFile ./zsh/zlogin;
    zlogout = builtins.readFile ./zsh/zlogout;
  };
}
