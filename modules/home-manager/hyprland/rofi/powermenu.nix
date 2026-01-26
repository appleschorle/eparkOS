{
  config,
  lib,
  pkgs,
  ...
}: let
  powerMenuScript = pkgs.replaceVars ./static/powermenu.sh {
    rofi = pkgs.rofi;
  };
  rofiPowerMenu = pkgs.writeShellScriptBin "rofi-powermenu" (builtins.readFile powerMenuScript);

  cfg = config.epark.hyprland.rofi.powermenu;
in {
  options.epark.hyprland.rofi.powermenu.enable = lib.mkEnableOption "Enable Powermenu for Rofi";

  config = lib.mkIf cfg.enable {
    home.packages = [
      rofiPowerMenu
    ];
  };
}
