{
  config,
  lib,
  ...
}: let
  cfg = config.epark.nixvim.globals;
in {
  imports = [];

  options = {
    epark.nixvim.globals.enable = lib.mkEnableOption "Enable NeoVim Globals";
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
