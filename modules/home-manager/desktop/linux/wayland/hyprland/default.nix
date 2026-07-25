{
  inputs,
  lib,
  config,
  ...
}: let
  cfg = config.epark.desktop.linux.wayland.hyprland;
in {
  imports = [
    ../../utilities/launch-menu
    ../../utilities/authentication.nix
    ../../utilities/clipboard.nix
    ../../utilities/colorpicker.nix
    ../../utilities/cursor.nix
    ../../utilities/dirs.nix
    ../../utilities/fonts.nix
    ../../utilities/idle.nix
    ../../utilities/lockscreen.nix
    ../../utilities/monitor.nix
    ../../utilities/notification
    ../../utilities/phone.nix
    ../../utilities/screenshot.nix
    ../../utilities/status-bar.nix
    ../../utilities/theme.nix
    ../../utilities/wallpaper.nix
  ];

  options.epark.desktop.linux.wayland.hyprland.enable = lib.mkEnableOption "Enable Hyprland";

  config = lib.mkIf cfg.enable {
    xdg.configFile."hypr/hyprland.lua" = {
      source = inputs.hyprland-dots + "/hyprland.lua";
    };

    epark.desktop.linux.utilities = {
      launchMenu.enable = true;
      authentication.enable = true;
      clipboard.enable = true;
      colorpicker.enable = true;
      cursor.enable = true;
      fonts.enable = true;
      idle.enable = true;
      lockscreen.enable = true;
      monitor.enable = false;
      notification.enable = true;
      phone.enable = true;
      screenshot.enable = true;
      statusBar.enable = true;
      theme.enable = true;
      wallpaper = {
        enable = true;
        # https://gruvbox-wallpapers.pages.dev/
        wallpaperSource = ./static/Wallpapers/gruvbox_astro.jpg;
      };
    };
  };
}
