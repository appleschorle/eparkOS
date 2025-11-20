{
  config,
  lib,
  ...
}:
with lib; {
  options.myBootLoader.enable = mkEnableOption "";

  config = mkIf config.myBootLoader.enable {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
