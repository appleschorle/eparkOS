{
  lib,
  config,
  ...
}: let
  cfg = config.epark.media;
in
  with lib; {
    options.epark.media.enable = mkEnableOption "Enable multimedia modules";

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

      programs.fuse.enable = true;
    };
  }
