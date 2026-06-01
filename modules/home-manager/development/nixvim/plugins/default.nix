{
  config,
  lib,
  ...
}: let
  cfg = config.epark.development.nixvim;
in {
  imports = [
    ./editing.nix
    ./language-support.nix
    ./navigation.nix
    ./productivity.nix
    ./ui.nix
  ];

  options = {
    epark.development.nixvim.plugins.enable = lib.mkEnableOption "Enable NeoVim Plugins";
  };

  config = lib.mkIf cfg.enable {
    epark.development.nixvim.plugins.editing.enable = true;
    epark.development.nixvim.plugins.language-support.enable = true;
    epark.development.nixvim.plugins.navigation.enable = true;
    epark.development.nixvim.plugins.productivity.enable = true;
    epark.development.nixvim.plugins.ui.enable = true;
  };
}
