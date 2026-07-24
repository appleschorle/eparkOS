{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.epark.desktop.app.discord;
in {
  options.epark.desktop.app.discord.enable = lib.mkEnableOption "Enable Discord";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      discord
    ];
  };
}
