{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.epark.ruby;
in {
  options.epark.ruby.enable = lib.mkEnableOption "Enable Ruby";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      ruby
    ];
  };
}
