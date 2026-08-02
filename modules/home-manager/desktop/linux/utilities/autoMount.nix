{
  config,
  lib,
  ...
}: let
  cfg = config.epark.desktop.linux.utilities.autoMount;
in {
  options.epark.desktop.linux.utilities.autoMount.enable =
    lib.mkEnableOption "Enable udiskie to auto mount usb";

  config = lib.mkIf cfg.enable {
    services.udiskie.enable = true;
  };
}
