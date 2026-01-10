{...}: {
  programs.lazygit = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      gui.theme = {
        selectedLineBgColor = ["default"];
      };
    };
  };
}
