{
  config,
  pkgs,
  lib,
  ...
}: let
  themeFileBackgroundImagePath = "rofi/themes/launchermenu.png";
  themeFilePath = "rofi/themes/launchermenu.rasi";
  colors = {
    bgHard = "1d2021"; # Hard contrast background
    borderGray = "665c54"; # Muted gray for borders
    textMain = "ebdbb2"; # Main foreground text color
    red = "fb4934"; # Error / alert / active highlight
  };

  themeFile = pkgs.replaceVars ./themes/launchermenu.rasi {
    bgHard = colors.bgHard;
    borderGray = colors.borderGray;
    textMain = colors.textMain;
    red = colors.red;

    backgroundImage = "/home/epark/.config/${themeFileBackgroundImagePath}";
  };

  launcherMenuScript = pkgs.replaceVars ./script/launchermenu.sh {
    rofi = pkgs.rofi;
    themeFile = "$HOME/.config/${themeFilePath}";
  };
  rofiLauncherMenu = pkgs.writeShellScriptBin "rofi-launchermenu" (builtins.readFile launcherMenuScript);
  cfg = config.epark.desktop.linux.utilities.launchMenu.app;
in {
  options.epark.desktop.linux.utilities.launchMenu.app.enable = lib.mkEnableOption "Enable application menu";
  config = lib.mkIf cfg.enable {
    home.packages = [
      rofiLauncherMenu
    ];

    xdg.configFile."${themeFilePath}".source = themeFile;
    xdg.configFile."${themeFileBackgroundImagePath}".source = ./themes/launchermenu.png;
  };
}
