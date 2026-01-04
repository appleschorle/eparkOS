{
  lib,
  config,
  ...
}: let
  cfg = config.epark.hyprland;
in
  with lib; {
    options.epark.hyprland.enable = mkEnableOption "Enable Hyprland";

    config = mkIf cfg.enable {
      imports = [
        ./hyprpaper.nix
        ./kanshi.nix
        ./rofi.nix
        ./waybar.nix
        ./hypridle.nix
        ./hyprlock.nix
        ./settings/keybinds.nix
      ];

      wayland.windowManager.hyprland = {
        enable = true;
        settings.exec-once = true;
      };
    };
  }
