{
  config,
  lib,
  ...
}: let
  cfg = config.epark.hyprland.settings.keybinds;
in {
  options.epark.hyprland.settings.keybinds.enable = lib.mkEnableOption "Enable keybind settings for Hyprland";

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      "$mod" = "SUPER";

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
          "$mod, Tab, workspace, e+1"
          "$mod SHIFT, Tab, workspace, e-1"
          "$mod, F, fullscreen, 0"
          "$mod, Space, togglefloating"
          "$mod, B, exec, firefox"
          "$mod, T, exec, kitty --hold tmux"
          "$mod, D, exec, rofi -show drun"
          "$mod, R, exec, rofi -show run"
          "$mod SHIFT, Q, killactive"
          "$mod CONTROL, H, movewindow, l"
          "$mod CONTROL, L, movewindow, r"
          "$mod CONTROL, K, movewindow, u"
          "$mod CONTROL, J, movewindow, d"
          "$mod+ALT, H, movecurrentworkspacetomonitor, l"
          "$mod+ALT, L, movecurrentworkspacetomonitor, r"
          "$mod+ALT, K, movecurrentworkspacetomonitor, u"
          "$mod+ALT, J, movecurrentworkspacetomonitor, d"
          "$mod, H, movefocus, l"
          "$mod, L, movefocus, r"
          "$mod, K, movefocus, u"
          "$mod, J, movefocus, d"
          "$mod, P, exec, grim -g \"\$(slurp -w 0)\" - | wl-copy"
          "$mod CONTROL, Q, exec, hyprlock"
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
}
