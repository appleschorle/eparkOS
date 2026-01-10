{
  config,
  lib,
  ...
}: let
  cfg = config.epark.sysc-greet;
in
  with lib; {
    options.epark.sysc-greet.enable = mkEnableOption "Enable sysc-greet";

    config = mkIf cfg.enable {
      services.sysc-greet = {
        enable = true;
        compositor = "hyprland";

        settings.initial_session = {
          command = "Hyprland";
          user = "epark";
        };
      };
    };
  }
