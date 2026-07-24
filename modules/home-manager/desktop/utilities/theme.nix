{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.epark.desktop.theme;
in {
  options.epark.desktop.theme.enable = lib.mkEnableOption "Enable Gruvbox Material theme and icons for desktop";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      gruvbox-material-gtk-theme
      papirus-icon-theme
      libsForQt5.qtstyleplugin-kvantum
      kdePackages.qtstyleplugin-kvantum
    ];

    gtk = {
      enable = true;
      theme = {
        name = "Gruvbox-Material-Dark-Medium";
        package = pkgs.gruvbox-material-gtk-theme;
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
      gtk4.theme = null;
    };

    qt = {
      enable = true;
      platformTheme.name = "kvantum";
      style.name = "kvantum";
    };

    home.sessionVariables = {
      QT_QPA_PLATFORM = "wayland;xcb";
      _JAVA_AWT_GTK_LOOKANDFEEL = "1";
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        icon-theme = "Papirus-Dark";
      };
    };

    xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=GruvboxDark
    '';
  };
}
