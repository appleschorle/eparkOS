{
  config,
  lib,
  pkgs,
  ...
}: let
  themeFileBackgroundImagePath = "rofi/themes/powermenu.jpg";
  themeFilePath = "rofi/themes/powermenu.rasi";
  themeFile = pkgs.replaceVars ./themes/powermenu.rasi {
    base00 = config.colorscheme.palette.base00;
    base03 = config.colorscheme.palette.base03;
    base05 = config.colorscheme.palette.base05;
    # base08 = config.colorscheme.palette.base08;
    base0B = config.colorscheme.palette.base0B;
    base0D = config.colorscheme.palette.base0D;
    backgroundImage = "/home/epark/.config/${themeFileBackgroundImagePath}";
  };

  powerMenuScript = pkgs.replaceVars ./static/powermenu.sh {
    rofi = pkgs.rofi;
    themeFile = "$HOME/.config/${themeFilePath}";
  };
  rofiPowerMenu = pkgs.writeShellScriptBin "rofi-powermenu" (builtins.readFile powerMenuScript);

  cfg = config.epark.hyprland.rofi.powermenu;
in {
  options.epark.hyprland.rofi.powermenu.enable = lib.mkEnableOption "Enable Powermenu for Rofi";

  config = lib.mkIf cfg.enable {
    home.packages = [
      rofiPowerMenu
    ];

    xdg.configFile."${themeFilePath}".source = themeFile;
    xdg.configFile."${themeFileBackgroundImagePath}".source = ./themes/powermenu.jpg;
  };
}
