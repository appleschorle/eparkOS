{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.epark.desktop.linux.phoneConnect.android;
in {
  options.epark.desktop.phoneConnect.android.enable =
    lib.mkEnableOption "Enable Android device tools and integration (KDE Connect, Mirroring, Transfer)";

  config = lib.mkIf cfg.enable {
    services.kdeconnect = {
      enable = true;
      indicator = true;
      package = pkgs.kdePackages.kdeconnect-kde;
    };

    home.packages = [
      pkgs.android-tools
      pkgs.scrcpy
      pkgs.qtscrcpy
      pkgs.localsend
    ];
  };
}
