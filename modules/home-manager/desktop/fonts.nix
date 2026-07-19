{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.epark.desktop.fonts;
in {
  options.epark.desktop.fonts.enable = lib.mkEnableOption "Enable system fonts and icon packages";

  config = lib.mkIf cfg.enable {
    # Force Home Manager to build and manage the local font cache
    fonts.fontconfig.enable = true;

    # The actual font libraries needed for your desktop user environment
    home.packages = with pkgs; [
      # Standard sans-serif text rendering fallback (prevents squares)
      noto-fonts
      noto-fonts-color-emoji

      # Your preferred Nerd Font for code, terminals, and icons
      nerd-fonts.fira-code
    ];
  };
}
