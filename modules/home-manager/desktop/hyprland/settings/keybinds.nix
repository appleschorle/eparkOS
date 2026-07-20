{
  config,
  lib,
  ...
}: let
  cfg = config.epark.desktop.hyprland.settings.keybinds;
  mkInline = str: lib.generators.mkLuaInline str;
in {
  options.epark.desktop.hyprland.settings.keybinds.enable =
    lib.mkEnableOption "Enable keybind settings for Hyprland";

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      settings = {
        # Declares a local Lua variable instead of an hl.<name>() call
        # mod = {_var = "SUPER";};

        # bindm = [
        #   {_args = ["SUPER + mouse:272" "movewindow"];}
        #   (mkInline ''mod .. ", mouse:273", "resizewindow"'')
        # ];

        bind = [
          {
            _args = [
              "SUPER + T"
              (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"kitty\")")
            ];
          }
          {
            _args = [
              "SUPER + B"
              (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"firefox\")")
            ];
          }
          {
            _args = [
              "SUPER + F"
              (lib.generators.mkLuaInline "hl.dsp.window.fullscreen({mode = \"fullscreen\", action = \"toggle\"})")
            ];
          }
          {
            _args = [
              "SUPER + Tab"
              (mkInline "hl.dsp.focus({ workspace = \"e+1\"})")
            ];
          }
          {
            _args = [
              "SUPER + SHIFT + Tab"
              (mkInline "hl.dsp.focus({ workspace = \"e-1\"})")
            ];
          }
          {
            _args = [
              "SUPER + 1"
              (mkInline "hl.dsp.focus({ workspace = \"1\"})")
            ];
          }
          {
            _args = [
              "SUPER + 2"
              (mkInline "hl.dsp.focus({ workspace = \"2\"})")
            ];
          }
          {
            _args = [
              "SUPER + SHIFT + Q"
              (mkInline "hl.dsp.window.kill()")
            ];
          }
          # Dynamic workspaces 1..9
        ];
        #     ++ (
        #       builtins.concatLists (builtins.genList (
        #           i: let
        #             ws = i + 1;
        #           in [
        #
        #             (mkInline ''mod .. ", code:1${toString i}", "workspace", "${toString ws}"'')
        #             (mkInline ''mod .. " SHIFT, code:1${toString i}", "movetoworkspace", "${toString ws}"'')
        #           ]
        #         )
        #         9)
        #     );
      };
    };
  };
}
