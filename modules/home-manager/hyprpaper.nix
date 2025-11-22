{
  lib,
  config,
  ...
}: let
  cfg = config.epark.hyprpaper;

  # https://gruvbox-wallpapers.pages.dev/
  homeWallpaperDir = "~/Wallpapers";
  nixWallpaper = "${homeWallpaperDir}/gruvbox-rainbow-nix.png";
  astronautWallpaper = "${homeWallpaperDir}/gruvbox_astro.jpg";
  pacmanWallpaper = "${homeWallpaperDir}/pacman-ghosts.png";
in
  with lib; {
    imports = [];

    options.epark.hyprpaper.enable = mkEnableOption "Enable Hyprpaper";

    config = mkIf cfg.enable {
      home.file."Wallpapers".source = ./Wallpapers;
      services.hyprpaper = {
        enable = true;
        settings = {
          preload = [nixWallpaper astronautWallpaper pacmanWallpaper];
          wallpaper = [
            "DP-2,${astronautWallpaper}" # Main
            "DP-1,${nixWallpaper}" # Vertical
            "eDP-1,${pacmanWallpaper}" # Built-In
          ];
        };
      };
    };
  }
