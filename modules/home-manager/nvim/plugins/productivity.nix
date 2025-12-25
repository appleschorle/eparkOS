{
  config,
  lib,
  ...
}: let
  cfg = config.epark.nvim.plugins.productivity;
in {
  imports = [];

  options = {
    epark.nvim.plugins.productivity.enable = lib.mkEnableOption "Enable NeoVim Plugins for Productivity Tools";
  };

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      plugins = {
        which-key.enable = true;
        trouble.enable = true;
        todo-comments.enable = true;
      };
    };
  };
}
