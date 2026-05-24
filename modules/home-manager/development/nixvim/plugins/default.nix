{
  config,
  lib,
  ...
}: let
  cfg = config.epark.nixvim;
in {
  imports = [
    ./editing.nix
    ./language-support.nix
    ./navigation.nix
    ./productivity.nix
    ./ui.nix
  ];

  options = {
    epark.nixvim.plugins.enable = lib.mkEnableOption "Enable NeoVim Plugins";
  };

  config = lib.mkIf cfg.enable {
    epark.nixvim.plugins.editing.enable = true;
    epark.nixvim.plugins.language-support.enable = true;
    epark.nixvim.plugins.navigation.enable = true;
    epark.nixvim.plugins.productivity.enable = true;
    epark.nixvim.plugins.ui.enable = true;
  };
}
