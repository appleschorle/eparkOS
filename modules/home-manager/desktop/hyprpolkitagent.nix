{
  config,
  lib,
  ...
}: let
  cfg = config.epark.desktop.hyprpolkitagent;
in {
  options.epark.desktop.hyprpolkitagent.enable = lib.mkEnableOption "Enable GUI hyprpolkit";

  config = lib.mkIf cfg.enable {
    services.hyprpolkitagent.enable = true;
  };
}
