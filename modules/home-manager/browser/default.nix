{
  config,
  lib,
  ...
}: let
  cfg = config.epark.browser;
in {
  imports = [
    ./firefox.nix
  ];

  options.epark.browser = {
    enable = lib.mkEnableOption "Enable browser and browser based apps";
  };

  config = lib.mkIf cfg.enable {
    epark.browser = {
      firefox = {
        enable = true;
      };
    };
  };
}
