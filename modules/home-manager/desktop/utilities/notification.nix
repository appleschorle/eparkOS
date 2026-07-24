{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.epark.desktop.dunst;
in {
  options.epark.desktop.dunst.enable = lib.mkEnableOption "Enable dunst";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      libnotify
    ];
    services.dunst = {
      enable = true;
      settings = {
        global = {
          enable_posix_regex = true;
          offset = "(10, 10)";
        };
      };
    };
  };
}
