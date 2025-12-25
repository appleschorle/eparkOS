{
  config,
  lib,
  ...
}: let
  cfg = config.epark.nvim;
in {
  imports = [
    ./editing.nix
    ./language-support.nix
    ./navigation.nix
    ./productivity.nix
    ./ui.nix
  ];

  options = {
    epark.nvim.plugins.enable = lib.mkEnableOption "Enable NeoVim Plugins";
  };

  config = lib.mkIf cfg.enable {
    epark.nvim.plugins.editing.enable = true;
    epark.nvim.plugins.language-support.enable = true;
    epark.nvim.plugins.navigation.enable = true;
    epark.nvim.plugins.productivity.enable = true;
    epark.nvim.plugins.ui.enable = true;
  };
}
