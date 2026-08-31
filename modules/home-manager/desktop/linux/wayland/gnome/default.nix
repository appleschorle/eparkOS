{
  lib,
  config,
  ...
}:
let
  cfg = config.epark.desktop.linux.wayland.gnome;
in
{
  options.epark.desktop.linux.wayland.gnome.enable = lib.mkEnableOption "Enable config for gnome";

  config = lib.mkIf cfg.enable {
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = [ "firefox.desktop" ];
        "x-scheme-handler/http" = [ "firefox.desktop" ];
        "x-scheme-handler/https" = [ "firefox.desktop" ];
      };
    };
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        clock-show-seconds = true;
        show-battery-percentage = true;
        accent-color = "green";
      };

      "org/gnome/desktop/wm/preferences" = {
        button-layout = "appmenu:minimize,maximize,close";
      };

      "org/gnome/desktop/background" = {
        picture-options = "zoom"; # Options: "none", "wallpaper", "centered", "scaled", "stretched", "zoom", "spanned"
        picture-uri = "file://${./gruvbox_astro.jpg}"; # Used in Light Mode
        picture-uri-dark = "file://${./gruvbox_astro.jpg}"; # Used in Dark Mode
      };

      "org/gnome/desktop/default-applications/terminal" = {
        exec = "ghostty";
      };

      "org.gnome.desktop.input-sources" = {
        sources = "[('xkb', 'us'), ('xkb', 'se'), ('xkb', 'de')]";
      };
    };
  };
}
