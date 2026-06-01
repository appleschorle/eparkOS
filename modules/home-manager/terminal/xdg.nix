{
  config,
  lib,
  ...
}: let
  cfg = config.epark.terminal.xdg;
in {
  options.epark.terminal.xdg = {
    enable = lib.mkEnableOption "Enable XDG";
  };

  config = lib.mkIf cfg.enable {
    xdg.enable = true;
  };
}
