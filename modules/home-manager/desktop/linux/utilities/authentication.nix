{
  config,
  lib,
  ...
}: let
  cfg = config.epark.desktop.linux.utilities.authentication;
in {
  options.epark.desktop.linux.utilities.authentication.enable = lib.mkEnableOption "Enable GUI hyprpolkit";

  config = lib.mkIf cfg.enable {
    services.hyprpolkitagent.enable = true;
  };
}
