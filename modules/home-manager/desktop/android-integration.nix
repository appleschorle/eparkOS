{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.epark.desktop.androidIntegration;
in {
  options.epark.desktop.androidIntegration.enable =
    lib.mkEnableOption "Enable Android device tools and integration (KDE Connect, Mirroring, Transfer)";

  config = lib.mkIf cfg.enable {
    # 1. User Services & Daemons (Automates background launching in Hyprland)
    services.kdeconnect = {
      enable = true;
      indicator = true;
      package = pkgs.kdePackages.kdeconnect-kde;
    };

    # 2. User Space Software Packages
    home.packages = [
      pkgs.android-tools
      pkgs.scrcpy # Screen mirroring engine
      pkgs.qtscrcpy # Graphical interface for scrcpy
      pkgs.localsend # Independent fast Wi-Fi file sharing
    ];
  };
}
