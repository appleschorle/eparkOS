{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.epark.development.ruby;
in {
  options.epark.development.ruby.enable = lib.mkEnableOption "Enable Ruby";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      ruby
    ];
  };
}
