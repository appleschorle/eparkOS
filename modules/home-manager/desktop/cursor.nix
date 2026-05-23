{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.epark.cursor;
in {
  options.epark.cursor.enable = lib.mkEnableOption "Enable cursor for desktop";

  config = lib.mkIf cfg.enable {
    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 16;
    };
  };
}
