{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.epark.desktop.icon-pack;
in {
  options.epark.desktop.icon-pack.enable = lib.mkEnableOption "Enable icon-pack";

  config = lib.mkIf cfg.enable {
    gtk = {
      enable = true;
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
    };

    home.packages = with pkgs; [
      papirus-icon-theme
    ];

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        icon-theme = "Papirus-Dark";
      };
    };
  };
}
