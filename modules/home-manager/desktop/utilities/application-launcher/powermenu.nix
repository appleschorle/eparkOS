{
  config,
  lib,
  pkgs,
  ...
}: let
  themeFileBackgroundImagePath = "rofi/themes/powermenu.png";
  themeFilePath = "rofi/themes/powermenu.rasi";
  themeFile = pkgs.replaceVars ./themes/powermenu.rasi {
    base00 = config.colorscheme.palette.base00;
    base03 = config.colorscheme.palette.base03;
    base05 = config.colorscheme.palette.base05;
    base08 = config.colorscheme.palette.base08;

    backgroundImage = "/home/epark/.config/${themeFileBackgroundImagePath}";
  };

  powerMenuScript = pkgs.replaceVars ./script/powermenu.sh {
    rofi = pkgs.rofi;
    themeFile = "$HOME/.config/${themeFilePath}";
  };
  rofiPowerMenu = pkgs.writeShellScriptBin "rofi-powermenu" (builtins.readFile powerMenuScript);

  cfg = config.epark.desktop.hyprland.rofi.powermenu;
in {
  options.epark.desktop.hyprland.rofi.powermenu.enable = lib.mkEnableOption "Enable Powermenu for Rofi";

  config = lib.mkIf cfg.enable {
    home.packages = [
      rofiPowerMenu
    ];

    xdg.configFile."${themeFilePath}".source = themeFile;
    xdg.configFile."${themeFileBackgroundImagePath}".source = ./themes/powermenu.png;
  };
}
