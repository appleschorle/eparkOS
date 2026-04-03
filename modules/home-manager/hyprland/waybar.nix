{
  config,
  lib,
  pkgs,
  ...
}: let
  colors = config.colorScheme.palette;
  waybarCss = pkgs.replaceVars ./static/waybar/index.css {
    bg = "#${colors.base00}";
    bg-alt = "#${colors.base02}";
    text = "#${colors.base05}";
    red = "#${colors.base08}";
    orange = "#${colors.base09}";
    yellow = "#${colors.base0A}";
    green = "#${colors.base0B}";
    blue = "#${colors.base0D}";
    cyan = "#${colors.base0C}";
  };
  cfg = config.epark.hyprland.waybar;
in {
  options.epark.hyprland.waybar = {
    enable = lib.mkEnableOption "Enable Waybar for Hyprland";
  };

  config = lib.mkIf cfg.enable {
    fonts.fontconfig.enable = true;
    programs.waybar = {
      enable = true;
      systemd.enable = true;

      style = waybarCss;

      settings = {
        mainBar = {
          position = "top";
          height = 0;
          width = 0;
          margin = "0";
          spacing = "0";

          modules-left = ["hyprland/workspaces"];
          modules-center = ["custom/divider#left_2" "clock#weekday" "custom/divider#left_1" "custom/logo" "custom/divider#right_1" "clock#time" "custom/divider#right_2"];
          modules-right = ["network" "battery" "pulseaudio" "backlight" "hyprland/language" "custom/power"];

          "custom/power" = {
            format = "";
            tooltip = false;
            on-click = "rofi-powermenu";
          };

          "custom/logo" = {
            format = "";
            tooltip = false;
          };
          "custom/divider#left_1" = {
            format = "";
            tooltip = false;
          };
          "custom/divider#right_1" = {
            format = "";
            tooltip = false;
          };
          "custom/divider#left_2" = {
            format = "";
            tooltip = false;
          };
          "custom/divider#right_2" = {
            format = "";
            tooltip = false;
          };

          pulseaudio = {
            format = "{icon}";
            format-icons = ["󰕿" "󰖀" "󰕾"];
            format-muted = ["󰝟"];
            format-source-muted = ["󰝟"];
            tooltip-format = "{volume}% | {desc}";
          };
          backlight = {
            format = "{icon}";
            format-icons = ["󰃝" "󰃞" "󰃟" "󰃠"];
            tooltip-format = "Brightness: {percent}%";
          };
          battery = {
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{icon}";
            format-icons = {
              default = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
              charging = ["󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂄"];
            };
            tooltip-format = "{capacity}% | {timeTo}";
          };
          "clock#weekday" = {
            format = "{:%a}";
            tooltip-format = "<tt><small>{calendar}</small></tt>";
            interval = 60;
            timezone = "Europe/Stockholm";
            calendar = {
              mode = "month";
              mode-mon-col = 3;
              weeks-pos = "right";
              on-scroll = 1;
              format = {
                months = "<span color='#d3869b'><b>{}</b></span>";
                days = "<span color='#d4be98'><b>{}</b></span>";
                weeks = "<span color='#89b482'><b>W{}</b></span>";
                weekdays = "<span color='#d8a657'><b>{}</b></span>";
                today = "<span color='#ea6962'><b><u>{}</u></b></span>";
              };
            };
            actions = {
              on-click-right = "mode";
              on-scroll-up = "shift_up";
              on-scroll-down = "shift_down";
            };
          };
          "clock#time" = {
            format = "{:%H:%M}";
            tooltip-format = "{:%d-%m-%Y}";
            interval = 60;
            timezone = "Europe/Stockholm";
          };
          network = {
            interval = 5;
            format = "{icon}";
            format-icons = ["󰤟" "󰤢" "󰤥" "󰤨"];
            format-ethernet = "󰈀{icon}";
            format-disconnected = "󰌙";
            tooltip-format = "{essid} ({signalStrength}%) ({bandwidthDownBits})";
            tooltip-format-disconnected = "Disconnected";
          };
          "hyprland/language" = {
            format = "{}";
            format-en = "🇺🇸";
            format-de = "🇩🇪";
            format-sv = "🇸🇪";
          };
        };
      };
    };
  };
}
