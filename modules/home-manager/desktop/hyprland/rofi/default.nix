{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.epark.desktop.hyprland.rofi;
in {
  imports = [
    ./powermenu.nix
    ./launchermenu.nix
  ];

  options.epark.desktop.hyprland.rofi.enable = lib.mkEnableOption "Enable Rofi";

  config = lib.mkIf cfg.enable {
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

    epark.desktop.hyprland.rofi = {
      powermenu.enable = true;
      launchermenu.enable = true;
    };
  };
}
