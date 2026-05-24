{
  lib,
  config,
  ...
}: let
  cfg = config.epark.hyprland;
in
  with lib; {
    imports = [
      ./hyprpaper.nix
      ./kanshi.nix
      ./rofi
      ./waybar.nix
      ./hypridle.nix
      ./hyprlock.nix
      ./keyboard_layout.nix
      ./settings/keybinds.nix
      ./settings/general.nix
    ];

    options.epark.hyprland.enable = mkEnableOption "Enable Hyprland";

    config = mkIf cfg.enable {
      wayland.windowManager.hyprland = {
        enable = true;
        settings.exec-once = true;
      };

      epark.hyprland = {
        hypridle.enable = true;
        hyprlock.enable = true;
        hyprpaper.enable = true;
        kanshi.enable = true;
        rofi.enable = true;
        waybar.enable = true;
        keyboard_layout.enable = true;

        settings = {
          general.enable = true;
          keybinds.enable = true;
        };
      };
    };
  }
