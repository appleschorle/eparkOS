{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.epark.desktop.app.libreOffice;
in {
  options.epark.desktop.app.libreOffice.enable = lib.mkEnableOption "Enable LibreOffice suite";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      libreoffice-fresh
    ];
  };
}
