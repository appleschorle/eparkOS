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
    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
      noto-fonts
      noto-fonts-color-emoji

      nerd-fonts.fira-code
    ];
  };
}
