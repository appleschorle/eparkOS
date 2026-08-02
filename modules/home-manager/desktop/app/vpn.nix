{
  lib,
  config,
  ...
}: let
  cfg = config.epark.desktop.app.vpn;
in {
  options.epark.desktop.app.vpn.enable = lib.mkEnableOption "Enable Mullvad VPN";

  config = lib.mkIf cfg.enable {
    programs.mullvad-vpn = {
      enable = true;
    };
  };
}
