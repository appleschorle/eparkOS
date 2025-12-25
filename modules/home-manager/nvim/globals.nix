{
  config,
  lib,
  ...
}: let
  cfg = config.epark.nvim.globals;
in {
  imports = [];

  options = {
    epark.nvim.globals.enable = lib.mkEnableOption "Enable NeoVim Globals";
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
