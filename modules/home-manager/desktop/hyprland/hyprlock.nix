{
  config,
  lib,
  ...
}: let
  colors = config.colorScheme.palette;
  defaultFontFamily = "FiraCode Nerd Font";
  cfg = config.epark.desktop.hyprland.hyprlock;
in {
  options.epark.desktop.hyprland.hyprlock.enable = lib.mkEnableOption "Enable Hyprlock for Hyprland";

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
          color = "rgb(${colors.base00})";
          path = "~/Wallpapers/gruvbox_astro.jpg";
          blur_passes = 1;
          blur_size = 2; # Small size (3-4) keeps details visible but soft
          noise = 0.01; # Tiny amount of noise prevents color banding
          contrast = 1.0; # Keep contrast at 1.0 to avoid darkening the subtle blur
          brightness = 1.0; # Keep brightness at 1.0 for a natural look
        };
        input-field = [
          {
            size = "300, 60";
            position = "0, -130";
            placeholder_text = "  Password";
            fade_on_empty = false;
            check_color = "rgb(${colors.base0A})";
            fail_color = "rgb(${colors.base08})";
            capslock_color = "rgb(${colors.base09})";
            numlock_color = "rgb(${colors.base0D})";
            bothlock_color = "rgb(${colors.base09}) rgb(${colors.base0D}) 90deg";
            font_color = "rgb(${colors.base05})";
            inner_color = "rgb(${colors.base01})";
            outer_color = "rgb(${colors.base03})";
            font-family = defaultFontFamily;
          }
        ];
        label = [
          # Time
          {
            text = "$TIME";
            color = "rgb(${colors.base05})";
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
            color = "rgb(${colors.base04})";
            font_size = 22;
            position = "0, 61";
            halign = "center";
            valign = "center";
            font-family = defaultFontFamily;
          }
          # User
          {
            text = "  $USER";
            color = "rgb(${colors.base05})";
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
