{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.epark.terminal;
in {
  imports = [
  ];

  options = {
    epark.terminal.enable = lib.mkEnableOption "Enable Terminal Configuration";
  };

  config =
    lib.mkIf cfg.enable {
    };
}
