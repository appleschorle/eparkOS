{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.epark.media;
in
  with lib; {
    options.epark.media.enable = mkEnableOption "Enable multimedia sound and screen sharing pipelines";

    config = mkIf cfg.enable {
      services.pipewire = {
        enable = true;
        pulse.enable = true;
        wireplumber.enable = true;

        alsa = {
          enable = true;
          support32Bit = true;
        };
      };

      xdg.portal = {
        enable = true;
        extraPortals = [pkgs.xdg-desktop-portal-gtk];
        config.common.default = "*";
      };
    };
  }
