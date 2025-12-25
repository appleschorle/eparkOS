{
  lib,
  config,
  ...
}: let
  cfg = config.epark.waybar;
in
  with lib; {
    imports = [];

    options.epark.waybar.enable = mkEnableOption "Enable Waybar";

    config = mkIf cfg.enable {
      programs.waybar = {
        enable = true;
        systemd.enable = true;
        settings = {
          mainBar = {
            position = "top";
            height = 32;
            spacing = 5;
            modules-left = ["hyprland/workspaces" "hyprland/window"];
            modules-right = ["battery" "clock"];
          };
          battery = {
            format = "{capacity}%";
          };
          clock = {
            format = "{:%H:%M}";
            tooltip-format = "<tt><small>{calendar}</small></tt>";
            interval = 60; # Update every 60 seconds
            timezone = "Europe/Stockholm";
          };
        };
      };
    };
  }
