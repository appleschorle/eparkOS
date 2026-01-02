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
      fonts.fontconfig.enable = true;
      programs.waybar = {
        enable = true;
        systemd.enable = true;

        style =
          # css
          ''
            @define-color bgdim #141617;
            @define-color bg5 #504945;
            @define-color fg #d4be98;
            @define-color gray #7c6f64;
            @define-color green #a9b665;
            @define-color yellow #d8a657;
            @define-color orange #e78a4e;
            @define-color red #ea6962;
            @define-color blue #7daea3;
            @define-color purple #d3869b;
            @define-color aqua #89b482;

            * {
              font-family: "FiraCode Nerd Font Propo";
              font-size: 14px;
              min-width: 32px;
              background-color: rgba(0, 0, 0, 0);
              color: @fg;
            }

            tooltip {
              background-color: @bg5;
            }

            #custom-logo {
              background-color: @bgdim;
              color: @blue;
              font-size: 24px;
              padding: 0;
            }

            #custom-divider {
              min-width: 0;
              font-size: 27px;
            }

            #custom-divider.right_1 {
              background-color: @bg5;
              color: @bgdim;
            }

            #custom-divider.right_2 {
              color: @bg5;
            }

            #custom-divider.left_1 {
              background-color: @bg5;
              color: @bgdim;
            }

            #custom-divider.left_2 {
              color: @bg5;
            }

            #clock {
              color: @aqua;
              background-color: @bg5;
              padding: 0 0.5rem;
            }

            #network,
            #battery,
            #pulseaudio,
            #backlight,
            #language {
              font-size: 16px;
            }

            #workspaces button.active {
              border-bottom: 1px solid @orange;
              border-radius: 0;
            }

            #battery.charging {
              color: @green;
            }

            #battery.warning {
              color: @orange;
            }

            #battery.critical {
              color: @red;
            }
          '';

        settings = {
          mainBar = {
            position = "top";
            height = 0;
            width = 0;
            margin = "0";
            spacing = "0";

            modules-left = ["hyprland/workspaces"];
            modules-center = ["custom/divider#left_2" "clock#weekday" "custom/divider#left_1" "custom/logo" "custom/divider#right_1" "clock#time" "custom/divider#right_2"];
            modules-right = ["network" "battery" "pulseaudio" "backlight" "hyprland/language"];

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
            };
          };
        };
      };
    };
  }
