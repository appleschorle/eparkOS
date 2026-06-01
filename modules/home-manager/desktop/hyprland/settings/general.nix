{
  config,
  lib,
  ...
}: let
  colors = config.colorScheme.palette;
  cfg = config.epark.desktop.hyprland.settings.general;
in {
  options.epark.desktop.hyprland.settings.general.enable = lib.mkEnableOption "Enable general settings for Hyprland";

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      general = {
        border_size = 2;
        gaps_out = 20;
        gaps_in = 10;
        "col.inactive_border" = "rgb(${colors.base02})";
        "col.active_border" = "rgb(${colors.base0B})";
      };

      decoration = {
        inactive_opacity = 0.7;
      };
    };
  };
}
