{
  config,
  lib,
  ...
}: let
  cfg = config.epark.nixvim.plugins.productivity;
in {
  imports = [];

  options = {
    epark.nixvim.plugins.productivity.enable = lib.mkEnableOption "Enable NeoVim Plugins for Productivity Tools";
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
