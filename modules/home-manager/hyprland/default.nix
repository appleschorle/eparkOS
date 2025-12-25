{
  lib,
  config,
  ...
}: let
  cfg = config.epark.hyprland;
in
  with lib; {
    imports = [
      ./hyprpaper.nix
      ./kanshi.nix
      ./rofi.nix
      ./waybar.nix
    ];

    options.epark.hyprland.enable = mkEnableOption "Enable Hyprland";

    config = mkIf cfg.enable {
      epark.kanshi.enable = true;
      epark.hyprpaper.enable = true;
      epark.rofi.enable = true;
      epark.waybar.enable = true;

      programs.hyprlock.enable = true;

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
              timeout = 300;
              on-timeout = "loginctl lock-session";
            }
            {
              timeout = 330;
              on-timeout = "hyprctl dispatch dpms off";
              on-resume = "hyprctl dispatch dpms on";
            }
            {
              timeout = 1800;
              on-timeout = "systemctl suspend";
            }
          ];
        };
      };

      wayland.windowManager.hyprland = {
        enable = true;
        settings = {
          "$mod" = "SUPER";

          exec-once = "hypridle";

          bindm = [
            # Move/resize windows with mainMod + LMB/RMB and dragging
            "$mod, mouse:272, movewindow"
            "$mod, mouse:273, resizewindow"
          ];
          bindel = [
            # Laptop multimedia keys for volume and LCD brightness
            ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
            ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
            ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
            ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
            ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
            ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
          ];
          bind =
            [
              "$mod, F, exec, firefox"
              "$mod, Return, exec, kitty"
              "$mod, SPACE, exec, rofi -show run"
              "$mod+CONTROL, L, exec, hyprlock"
              "$mod, Q, killactive"
              "$mod, H, movefocus, l"
              "$mod, L, movefocus, r"
              "$mod, K, movefocus, u"
              "$mod, J, movefocus, d"
              "$mod, P, exec, grim -g \"\$(slurp -w 0)\" - | wl-copy"
            ]
            ++ (
              # workspaces
              # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
              builtins.concatLists (builtins.genList (
                  i: let
                    ws = i + 1;
                  in [
                    "$mod, code:1${toString i}, workspace, ${toString ws}"
                    "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
                  ]
                )
                9)
            );
        };
      };
    };
  }
