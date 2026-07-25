{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.epark.desktop.linux.utilities.colorpicker;
in {
  options.epark.desktop.linux.utilities.colorpicker.enable = lib.mkEnableOption "Enable hyprpicker";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.hyprpicker
    ];
  };
}
