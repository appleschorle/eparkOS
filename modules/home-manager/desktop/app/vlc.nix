{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.epark.desktop.app.vlc;
in {
  options.epark.desktop.app.vlc.enable = lib.mkEnableOption "Enable VLC media player";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      vlc
    ];
  };
}
