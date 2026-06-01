{
  config,
  lib,
  ...
}: let
  cfg = config.epark.desktop.hyprland.hypridle;
in {
  options.epark.desktop.hyprland.hypridle.enable = lib.mkEnableOption "Enable Hypridle for Hyprland";

  config = lib.mkIf cfg.enable {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };

        listener = [
          {
            timeout = 3000;
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 4500;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
          {
            timeout = 18000;
            on-timeout = "systemctl suspend";
          }
        ];
      };
    };
  };
}
