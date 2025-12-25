{
  lib,
  config,
  ...
}: let
  cfg = config.epark.rofi;
in
  with lib; {
    imports = [];

    options.epark.rofi.enable = mkEnableOption "Enable Rofi";

    config = mkIf cfg.enable {
      programs.rofi = {
        enable = true;
      };
    };
  }
