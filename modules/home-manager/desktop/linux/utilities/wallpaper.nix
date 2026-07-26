{
  config,
  lib,
  ...
}: let
  wallpaperFilename = baseNameOf cfg.wallpaperSource;
  deployedPath = "~/Wallpapers/${wallpaperFilename}";
  cfg = config.epark.desktop.linux.utilities.wallpaper;
in {
  options.epark.desktop.linux.utilities.wallpaper = {
    enable = lib.mkEnableOption "Enable Hyprpaper for Hyprland";
    wallpaperSource = lib.mkOption {
      type = lib.types.path;
      description = "Path to the Wallpaper image";
    };
  };

  config = lib.mkIf cfg.enable {
    home.file."Wallpapers/${wallpaperFilename}".source = cfg.wallpaperSource;
    services.hyprpaper = {
      enable = true;
      settings = {
        preload = [deployedPath];
        splash = false;

        wallpaper = [
          {
            monitor = "";
            path = deployedPath;
          }
        ];
      };
    };
  };
}
