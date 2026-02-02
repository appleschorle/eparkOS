{
  config,
  lib,
  ...
}: let
  cfg = config.epark.nixvim.highlight;
in {
  imports = [];

  options = {
    epark.nixvim.highlight.enable = lib.mkEnableOption "Enable NeoVim Highlight Groups";
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
