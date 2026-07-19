{
  config,
  lib,
  ...
}: let
  cfg = config.epark.desktop.hyprland.keyboard_layout;
in {
  options.epark.desktop.hyprland.keyboard_layout = {
    enable = lib.mkEnableOption "Enable Different Keyboard Layouts for Hyprland";
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      # settings = {
      #   input = {
      #     kb_layout = "us,se,de";
      #     kb_variant = ",,";
      #
      #     kb_options = "grp:alt_space_toggle";
      #
      #     follow_mouse = 1;
      #     touchpad.natural_scroll = false;
      #   };
      # };
    };
  };
}
