{...}: let
  # https://gruvbox-wallpapers.pages.dev/
  astronautWallpaper = "~/Wallpapers/gruvbox_astro.jpg";
in {
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
}
