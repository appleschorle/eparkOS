{
  lib,
  config,
  ...
}: let
  cfg = config.epark.development.direnv;
in {
  options.epark.development.direnv.enable = lib.mkEnableOption "Enable DirEnv";

  config = lib.mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      silent = true;
      nix-direnv.enable = true;
    };
  };
}
