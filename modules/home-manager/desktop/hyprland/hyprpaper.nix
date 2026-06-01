{
  config,
  lib,
  ...
}: let
  # https://gruvbox-wallpapers.pages.dev/
  astronautWallpaper = "~/Wallpapers/gruvbox_astro.jpg";
  cfg = config.epark.desktop.hyprland.hyprpaper;
in {
  options.epark.desktop.hyprland.hyprpaper.enable = lib.mkEnableOption "Enable Hyprpaper for Hyprland";

  config = lib.mkIf cfg.enable {
    home.file."Wallpapers".source = ./static/Wallpapers;
    services.hyprpaper = {
      enable = true;
      settings = {
        preload = [astronautWallpaper];
        wallpaper = [
          "DP-2,${astronautWallpaper}" # Main
          "DP-1,${astronautWallpaper}" # Vertical
          "eDP-1,${astronautWallpaper}" # Built-In
        ];
      };
    };
  };
}
