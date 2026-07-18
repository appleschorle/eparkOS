{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.epark.desktop.theme;
in {
  options.epark.desktop.theme.enable = lib.mkEnableOption "Enable Gruvbox Material theme for desktop";

  config = lib.mkIf cfg.enable {
    # 1. Theme packages required for rendering
    home.packages = with pkgs; [
      gruvbox-material-gtk-theme
      gruvbox-material-icon-theme
      libsForQt5.qtstyleplugin-kvantum
      kdePackages.kvantum
    ];

    # 2. GTK Application Theme
    gtk = {
      enable = true;
      theme = {
        name = "Gruvbox-Material-Dark-Medium";
        package = pkgs.gruvbox-material-gtk-theme;
      };
      iconTheme = {
        name = "Gruvbox-Material-Dark";
        package = pkgs.gruvbox-material-icon-theme;
      };
    };

    # 3. Qt Application Theme (Using Kvantum to match GTK)
    qt = {
      enable = true;
      platformTheme.name = "kvantum";
      style.name = "kvantum";
    };

    # 4. Global environment variables for Wayland & Java compatibility
    home.sessionVariables = {
      QT_QPA_PLATFORM = "wayland;xcb";
      _JAVA_AWT_GTK_LOOKANDFEEL = "1";
    };

    # 5. Declarative Kvantum configuration file
    xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=GruvboxDark
    '';
  };
}
