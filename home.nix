{pkgs, ...}: {
    home.username = "epark";
    home.homeDirectory = "/home/epark";    
    # home.stateVersion = "24.11"; # Comment out for error with "latest" version
    programs.home-manager.enable = true;
    configurations = {
	programs.zsh.enable = true;
	programs.git.enable = true;
    };
    wayland.windowManager.hyprland = {
	enable = true;
	settings = {
    "$mod" = "SUPER";
    bind =
      [
        "$mod, F, exec, firefox"
        "$mod, Q, exec, kitty"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
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
