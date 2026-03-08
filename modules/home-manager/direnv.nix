{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.epark.direnv;
in
  with lib; {
    imports = [];

    options.epark.direnv.enable = mkEnableOption "Enable DirEnv";

    config = mkIf cfg.enable {
      programs.direnv = {
        enable = true;
        nix-direnv = {
          enable = true;
        };
      };
    };
  }
