{config, ...}: let
  colors = config.colorScheme.palette;
in {
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
}
