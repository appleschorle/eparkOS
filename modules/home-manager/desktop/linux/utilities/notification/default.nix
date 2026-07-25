{
  config,
  lib,
  pkgs,
  ...
}: let
  volumeChange = pkgs.writeShellScriptBin "volume-change" (builtins.readFile ./static/volume-change.sh);
  brightnessChange = pkgs.writeShellScriptBin "brightness-change" (builtins.readFile ./static/brightness-change.sh);

  cfg = config.epark.desktop.linux.utilities.notification;
in {
  options.epark.desktop.linux.utilities.notification.enable = lib.mkEnableOption "Enable dunst";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      libnotify
      volumeChange
      brightnessChange
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
