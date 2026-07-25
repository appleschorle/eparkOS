{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.epark.desktop.linux.utilities.clipboard;
in {
  options.epark.desktop.linux.utilities.clipboard.enable =
    lib.mkEnableOption "Enable persistent clipboard history via cliphist";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      cliphist
      wl-clipboard
    ];

    services.cliphist = {
      enable = true;
      allowImages = true;
    };
  };
}
