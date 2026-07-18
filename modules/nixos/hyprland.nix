{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.epark.hyprland;
in
  with lib; {
    options.epark.hyprland.enable = mkEnableOption "Enable Hyprland";

    config = mkIf cfg.enable {
      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
      };

      xdg.portal = {
        enable = true;
        extraPortals = [pkgs.xdg-desktop-portal-gtk];
        config.common.default = "*";
      };

      # Electron apps running on Wayland
      environment.sessionVariables.NIXOS_OZONE_WL = "1";
    };
  }
