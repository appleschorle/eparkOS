{
  config,
  lib,
  ...
}: let
  cfg = config.epark.nixvim.plugins.editing;
in {
  imports = [];

  options = {
    epark.nixvim.plugins.editing.enable = lib.mkEnableOption "Enable NeoVim Plugins for Editing";
  };

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      plugins = {
        blink-cmp.enable = true;
        undotree.enable = true;
        nvim-autopairs.enable = true;
        nvim-surround.enable = true;
      };
    };
  };
}
