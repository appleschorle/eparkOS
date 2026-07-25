{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.epark.desktop.linux.utilities.launchMenu;
in {
  imports = [
    ./power.nix
    ./app.nix
  ];

  options.epark.desktop.linux.utilities.launchMenu.enable = lib.mkEnableOption "Enable launch menu";

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

    epark.desktop.linux.utilities.launchMenu = {
      app.enable = true;
      power.enable = true;
    };
  };
}
