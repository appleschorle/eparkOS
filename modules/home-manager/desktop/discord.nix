{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.epark.desktop.discord;
in {
  options.epark.desktop.discord.enable = lib.mkEnableOption "Enable Discord";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.discord
    ];
  };
}
