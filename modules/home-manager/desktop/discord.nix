{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.epark.discord;
in
  with lib; {
    imports = [];

    options.epark.discord.enable = mkEnableOption "Enable Discord";

    config = mkIf cfg.enable {
      home.packages = [
        pkgs.discord
      ];
    };
  }
