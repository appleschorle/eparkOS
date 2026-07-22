{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.epark.desktop.colorPicker;
in {
  options.epark.desktop.colorPicker.enable = lib.mkEnableOption "Enable hyprpicker";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.hyprpicker
    ];
  };
}
