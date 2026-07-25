{
  inputs,
  config,
  lib,
  ...
}: let
  cfg = config.epark.desktop.linux.utilities.statusBar;
in {
  options.epark.desktop.linux.utilities.statusBar = {
    enable = lib.mkEnableOption "Enable a status bar";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."waybar" = {
      source = inputs.waybar-dots;
      recursive = true;
    };
    programs.waybar = {
      enable = true;
      systemd.enable = true;
    };
  };
}
