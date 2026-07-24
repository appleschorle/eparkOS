{
  config,
  lib,
  pkgs,
  ...
}: let
  themeFileBackgroundImagePath = "rofi/themes/launchermenu.png";
  themeFilePath = "rofi/themes/launchermenu.rasi";
  themeFile = pkgs.replaceVars ./themes/launchermenu.rasi {
    base00 = config.colorscheme.palette.base00;
    base03 = config.colorscheme.palette.base03;
    base05 = config.colorscheme.palette.base05;
    base08 = config.colorscheme.palette.base08;

    backgroundImage = "/home/epark/.config/${themeFileBackgroundImagePath}";
  };

  launcherMenuScript = pkgs.replaceVars ./script/launchermenu.sh {
    rofi = pkgs.rofi;
    themeFile = "$HOME/.config/${themeFilePath}";
  };
  rofiLauncherMenu = pkgs.writeShellScriptBin "rofi-launchermenu" (builtins.readFile launcherMenuScript);

  cfg = config.epark.desktop.hyprland.rofi.launchermenu;
in {
  options.epark.desktop.hyprland.rofi.launchermenu.enable = lib.mkEnableOption "Enable launcher menu for Rofi";

  config = lib.mkIf cfg.enable {
    home.packages = [
      rofiLauncherMenu
    ];

    xdg.configFile."${themeFilePath}".source = themeFile;
    xdg.configFile."${themeFileBackgroundImagePath}".source = ./themes/launchermenu.png;
  };
}
