{pkgs, ...}: {
  imports = [./powermenu.nix];

  config = {
    programs.rofi = {
      enable = true;
      extraConfig = {
        show-icons = true;
      };
      modes = ["run" "drun" "window"];
      font = "FiraCode Nerd Font 14";
      theme = "gruvbox-dark-hard";
      terminal = "${pkgs.kitty}/bin/kitty";
    };
  };
}
