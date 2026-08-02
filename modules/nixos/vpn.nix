{
  lib,
  config,
  ...
}: let
  cfg = config.epark.vpn;
in
  with lib; {
    options.epark.vpn.enable = mkEnableOption "Enable Mullvad services";

    config = mkIf cfg.enable {
      services.mullvad-vpn = {
        enable = true;
      };
    };
  }
