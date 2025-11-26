{flakeRootPath, ...}: {
  home = {
    username = "epark";
    homeDirectory = "/home/epark";
    stateVersion = "25.05";
  };
  programs.home-manager.enable = true;

  imports = [
    "${flakeRootPath}/modules/home-manager/editors/nvim.nix"
    "${flakeRootPath}/modules/home-manager/kanshi.nix"
    "${flakeRootPath}/modules/home-manager/hyprpaper.nix"
    "${flakeRootPath}/modules/home-manager/rofi.nix"
    "${flakeRootPath}/modules/home-manager/waybar.nix"
    "${flakeRootPath}/modules/home-manager/git.nix"
  ];

  epark.kanshi.enable = true;
  epark.nvim.enable = true;
  epark.hyprpaper.enable = true;
  epark.rofi.enable = true;
  epark.waybar.enable = true;
  epark.git.enable = true;

  wayland.windowManager.hyprland.enable = true;
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
        "$mod, F, exec, firefox"
        "$mod, Return, exec, kitty"
        "$mod, SPACE, exec, rofi -show run"
        "$mod, C, killactive"
        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"
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
}
