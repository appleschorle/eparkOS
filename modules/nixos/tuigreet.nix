{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.epark.tuigreet;
in
  with lib; {
    options.epark.tuigreet.enable = mkEnableOption "Enable Tuigreet";

    config = mkIf cfg.enable {
      services.greetd.enable = true;
      services.greetd.settings.default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session --sessions ${pkgs.hyprland}/share/wayland-sessions";
        user = "epark";
      };
    };
  }
