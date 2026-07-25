{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.epark.desktop.linux.utilities.screenshot;
in {
  options.epark.desktop.linux.utilities.screenshot.enable = lib.mkEnableOption "Enable Gruvbox Material theme and icons for desktop";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      grim
      slurp
      swappy
      wl-clipboard
    ];
  };
}
