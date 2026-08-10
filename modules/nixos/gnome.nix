{
  lib,
  config,
  ...
}: let
  cfg = config.epark.gnome;
in
  with lib; {
    options.epark.gnome.enable = mkEnableOption "Enable Gnome";

    config = mkIf cfg.enable {
      services.displayManager.gdm.enable = true;
      services.desktopManager.gnome.enable = true;

      programs.dconf.enable = true;

      environment.sessionVariables.NIXOS_OZONE_WL = "1";
    };
  }
