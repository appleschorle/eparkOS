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

        style = builtins.readFile ./static/style.css;

        settings = {
          mainBar = {
            position = "top";
            height = 35;
            spacing = 5;

            modules-left = ["hyprland/workspaces"];
            modules-right = ["network" "battery" "hyprland/language" "clock"];

            battery = {
              format = "BAT: {capacity}%";
            };
            clock = {
              format = "{:%a | %H:%M}";
              tooltip-format = "<tt><small>{calendar}</small></tt>";
              interval = 60; # Update every 60 seconds
              timezone = "Europe/Stockholm";
            };
            network = {
              interface = "wlp2s0";
              format = "{ifname}";
              format-wifi = "{essid} ({signalStrength}%)";
              format-ethernet = "{ipaddr}/{cidr}";
              format-disconnected = "Disconnected";
              tooltip-format = "{ifname} via {gwaddr}";
              tooltip-format-wifi = "{essid} ({signalStrength}%)";
              tooltip-format-ethernet = "{ifname}";
              tooltip-format-disconnected = "Disconnected";
              max-length = 50;
            };
            "hyprland/language" = {
              format = "{}";
            };
          };
        };
      };
    };
  }
