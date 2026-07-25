{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.epark.desktop.linux.utilities.cursor;
in {
  options.epark.desktop.linux.utilities.cursor.enable = lib.mkEnableOption "Enable cursor for desktop";

  config = lib.mkIf cfg.enable {
    home.pointerCursor = {
      enable = true;
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 16;
    };
  };
}
