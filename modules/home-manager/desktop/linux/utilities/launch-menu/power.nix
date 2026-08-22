{
  config,
  pkgs,
  lib,
  ...
}: let
  themeFileBackgroundImagePath = "rofi/themes/powermenu.png";
  themeFilePath = "rofi/themes/powermenu.rasi";
  themeFile = pkgs.replaceVars ./themes/powermenu.rasi {
    backgroundImage = "/home/epark/.config/${themeFileBackgroundImagePath}";
  };

  powerMenuScript = pkgs.replaceVars ./script/powermenu.sh {
    rofi = pkgs.rofi;
    themeFile = "$HOME/.config/${themeFilePath}";
  };
  rofiPowerMenu = pkgs.writeShellScriptBin "rofi-powermenu" (builtins.readFile powerMenuScript);
  cfg = config.epark.desktop.linux.utilities.launchMenu.power;
in {
  options.epark.desktop.linux.utilities.launchMenu.power.enable = lib.mkEnableOption "Enable power menu";

  config = lib.mkIf cfg.enable {
    home.packages = [
      rofiPowerMenu
    ];

    xdg.configFile."${themeFilePath}".source = themeFile;
    xdg.configFile."${themeFileBackgroundImagePath}".source = ./themes/powermenu.png;
  };
}
