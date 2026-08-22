{
  config,
  lib,
  ...
}: let
  defaultFontFamily = "FiraCode Nerd Font";
  cfg = config.epark.desktop.linux.utilities.lockscreen;

  colors = {
    bgHard = "1d2021"; # Hard contrast background
    bgLight = "3c3836"; # Lighter background for inner fields
    borderGray = "665c54"; # Muted gray for borders
    textMuted = "bdae93"; # Muted text color
    textMain = "ebdbb2"; # Main foreground text color
    red = "fb4934"; # Error / alert
    orange = "fe8019"; # Warning / caps lock
    yellow = "fabd2f"; # Check / processing
    blue = "83a598"; # Informational / num lock
  };
in {
  options.epark.desktop.linux.utilities.lockscreen.enable = lib.mkEnableOption "Enable Hyprlock for Hyprland";

  config = lib.mkIf cfg.enable {
    programs.hyprlock = {
      enable = true;

      settings = {
        general = {
          grace = 0;
          ignore_empty_input = true;
          fail_timeout = 1500;
        };
        animations = {
          enabled = false;
          bezier = ["easeOutQuint, 0.23, 1, 0.32, 1"];
          animation = ["global, 1, 1, easeOutQuint"];
        };
        background = {
          color = "rgb(${colors.bgHard})";
          path = "~/Wallpapers/gruvbox_astro.jpg";
          blur_passes = 1;
          blur_size = 2;
          noise = 0.01;
          contrast = 1.0;
          brightness = 1.0;
        };
        input-field = [
          {
            size = "300, 60";
            position = "0, -130";
            placeholder_text = "  Password";
            fade_on_empty = false;
            check_color = "rgb(${colors.yellow})";
            fail_color = "rgb(${colors.red})";
            capslock_color = "rgb(${colors.orange})";
            numlock_color = "rgb(${colors.blue})";
            bothlock_color = "rgb(${colors.orange}) rgb(${colors.blue}) 90deg";
            font_color = "rgb(${colors.textMain})";
            inner_color = "rgb(${colors.bgLight})";
            outer_color = "rgb(${colors.borderGray})";
            font-family = defaultFontFamily;
          }
        ];
        label = [
          # Time
          {
            text = "$TIME";
            color = "rgb(${colors.textMain})";
            font_size = 128;
            position = "0, 161";
            halign = "center";
            valign = "center";
            font-family = defaultFontFamily;
          }
          # Date
          {
            text =
              # bash
              ''cmd[update:1000] echo "<span>$(date +"%d %B, %a.")</span>"'';
            color = "rgb(${colors.textMuted})";
            font_size = 22;
            position = "0, 61";
            halign = "center";
            valign = "center";
            font-family = defaultFontFamily;
          }
          # User
          {
            text = "  $USER";
            color = "rgb(${colors.textMain})";
            font_size = 22;
            position = "0, -61";
            halign = "center";
            valign = "center";
            outline_thickness = 2;
            font-family = defaultFontFamily;
          }
        ];
      };
    };
  };
}
