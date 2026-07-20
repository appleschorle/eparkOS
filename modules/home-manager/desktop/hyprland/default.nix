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
    ./waybar.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./keyboard_layout.nix
    ./settings/keybinds.nix
    ./settings/general.nix
  ];

  options.epark.desktop.hyprland.enable = lib.mkEnableOption "Enable Hyprland";

  config = lib.mkIf cfg.enable {
    # wayland.windowManager.hyprland = {
    #   enable = true;
    # };

    xdg.configFile."hypr/hyprland.lua" = {
      source = inputs.hyprland-dots + "/hyprland.lua";
      # recursive = true;
    };

    epark.desktop.hyprland = {
      # hypridle.enable = true;
      # hyprlock.enable = true;
      # hyprpaper.enable = true;
      # kanshi.enable = true;
      # rofi.enable = true;
      waybar.enable = true;
      # keyboard_layout.enable = true;

      # settings = {
      #   general.enable = true;
      #   keybinds.enable = true;
      # };
    };
  };
}
