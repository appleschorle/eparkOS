{
  config,
  lib,
  ...
}: let
  cfg = config.epark.development.nixvim.globals;
in {
  imports = [];

  options = {
    epark.development.nixvim.globals.enable = lib.mkEnableOption "Enable NeoVim Globals";
  };

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      globals = {
        mapleader = " ";
        maplocalleader = "\\";
      };
    };
  };
}
