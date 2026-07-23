{
  inputs,
  lib,
  config,
  ...
}: let
  cfg = config.epark.desktop.hyprland;
in {
  imports = [
    ./hyprpaper.nix
    ./kanshi.nix
    ./rofi
    ./hypridle.nix
    ./hyprlock.nix
  ];

  options.epark.desktop.hyprland.enable = lib.mkEnableOption "Enable Hyprland";

  config = lib.mkIf cfg.enable {
    xdg.configFile."hypr/hyprland.lua" = {
      source = inputs.hyprland-dots + "/hyprland.lua";
    };

    epark.desktop.hyprland = {
      # hypridle.enable = true;
      hyprlock.enable = true;
      hyprpaper.enable = true;
      # kanshi.enable = true;
      rofi.enable = true;
    };
  };
}
