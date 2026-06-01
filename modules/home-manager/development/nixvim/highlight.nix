{
  config,
  lib,
  ...
}: let
  cfg = config.epark.development.nixvim.highlight;
in {
  imports = [];

  options = {
    epark.development.nixvim.highlight.enable = lib.mkEnableOption "Enable NeoVim Highlight Groups";
  };

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      highlight = {
        IblScope = {
          fg = "#ea6962";
        };
      };
    };
  };
}
