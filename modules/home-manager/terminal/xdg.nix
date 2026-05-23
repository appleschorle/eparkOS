{
  config,
  lib,
  ...
}: let
  cfg = config.epark.xdg;
in {
  options.epark.xdg = {
    enable = lib.mkEnableOption "Enable XDG";
  };

  config = lib.mkIf cfg.enable {
    xdg.enable = true;
  };
}
