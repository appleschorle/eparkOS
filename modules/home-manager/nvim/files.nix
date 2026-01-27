{
  config,
  lib,
  ...
}: let
  cfg = config.epark.nixvim.files;
in {
  options.epark.nixvim.files.enable = lib.mkEnableOption "Enable files for NixVim";

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      files = {
        "ftplugin/nix.lua" = {
          opts = {
            expandtab = true;
            shiftwidth = 2;
            tabstop = 2;
          };
        };
      };
    };
  };
}
