{
  inputs,
  config,
  lib,
  ...
}: let
  cfg = config.epark.desktop.waybar;
in {
  options.epark.desktop.waybar = {
    enable = lib.mkEnableOption "Enable Waybar";
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
