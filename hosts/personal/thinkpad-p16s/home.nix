{
  pkgs,
  inputs,
  flakeRootPath,
  ...
}: {
  home = {
    username = "epark";
    homeDirectory = "/home/epark";
    stateVersion = "25.05";
    # packages = with pkgs; [
    # 	git
    # ];
  };
  programs.home-manager.enable = true;

  imports = [
    "${flakeRootPath}/modules/nvim.nix"
  ];

  myNvim.enable = true;

  # xdg.enable = true;
  # xdg.configFile."nvim".source = ../../../dotfiles/nvim;

  # https://jvns.ca/blog/2024/02/16/popular-git-config-options/
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      user.name = "Eugene Park";
      user.email = "eugenepark2001@gmail.com";
      pull.rebase = true;
      push.autoSetupRemote = true;
      help.autocorrect = "prompt";
      # https://luppeng.wordpress.com/2020/10/10/when-to-use-each-of-the-git-diff-algorithms/
      diff.algorithm = "histogram";
    };
  };

  services.kanshi = {
    enable = true;
    systemdTarget = "hyprland-session.target";
    profiles = {
      laptop = {
        outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            mode = "1920x1200@60.00Hz";
            scale = 1.0;
          }
        ];
      };

      laptopmain = {
        outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            mode = "1920x1200@60.00Hz";
            position = "0,1200";
            scale = 1.0;
          }

          # main
          {
            criteria = "Dell Inc. DELL P2425HE CNQFD94";
            mode = "1920x1080@100.00Hz";
            position = "0,0";
            scale = 1.0;
          }
        ];
      };

      laptopvertical = {
        outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            mode = "1920x1200@60.00Hz";
            scale = 1.0;
          }

          # rotated
          {
            criteria = "Dell Inc. DELL P2425HE FNQFD94";
            mode = "1920x1080@100.00Hz";
            position = "1920,0";
            transform = "90";
            scale = 1.0;
          }
        ];
      };

      dock = {
        outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
            scale = 1.0;
          }

          # main
          {
            criteria = "Dell Inc. DELL P2425HE CNQFD94";
            mode = "1920x1080@100.00Hz";
            position = "0,0";
            scale = 1.0;
          }

          # rotated
          {
            criteria = "Dell Inc. DELL P2425HE FNQFD94";
            mode = "1920x1080@100.00Hz";
            position = "1920,0";
            transform = "90";
            scale = 1.0;
          }
        ];
      };
    };
  };

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
