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
        withUWSM = true;
      };

      xdg.portal = {
        enable = true;
        extraPortals = [pkgs.xdg-desktop-portal-gtk];
        config.common.default = "*";
      };

      security.polkit.enable = true;

      # Electron apps running on Wayland
      environment.sessionVariables.NIXOS_OZONE_WL = "1";

      environment.systemPackages = with pkgs; [
        nemo-with-extensions

        grim
        slurp
        swappy
        wl-clipboard
      ];

      programs.evince.enable = true;

      # Open firewall ports automatically
      programs.kdeconnect.enable = true;
      services.gvfs.enable = true;
    };
  }
