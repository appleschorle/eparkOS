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
      ./rofi.nix
      ./waybar.nix
      ./hypridle.nix
      ./hyprlock.nix
      ./settings/keybinds.nix
    ];

    options.epark.hyprland.enable = mkEnableOption "Enable Hyprland";

    config = mkIf cfg.enable {
      wayland.windowManager.hyprland = {
        enable = true;
        settings.exec-once = true;
      };
    };
  }
