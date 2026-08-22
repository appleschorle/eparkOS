{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.epark.desktop.hyprland;
in
  with lib; {
    options.epark.desktop.hyprland.enable = mkEnableOption "Enable Hyprland";

    config = mkIf cfg.enable {
      # Electron apps running on Wayland
      environment.sessionVariables.NIXOS_OZONE_WL = "1";
      environment.systemPackages = with pkgs; [
        nemo-with-extensions
        brightnessctl
      ];

      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
        withUWSM = true;
      };

      xdg.portal = {
        enable = true;
        extraPortals = [pkgs.xdg-desktop-portal-gtk];
        config.common.default = "*";
      };

      security.polkit.enable = true;

      programs.evince.enable = true;

      # Open firewall ports automatically
      programs.kdeconnect.enable = true;
      services.gvfs.enable = true;

      services.greetd.enable = true;
      services.greetd.settings.default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd 'uwsm start hyprland.desktop'";
        user = "epark";
      };
    };
  }
