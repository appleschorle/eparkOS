{
  config,
  lib,
  ...
}: let
  cfg = config.epark.nvim.opts;
in {
  imports = [];

  options = {
    epark.nvim.opts.enable = lib.mkEnableOption "Enable NeoVim Options";
  };

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      opts = {
        number = true;
        relativenumber = true;
        scrolloff = 999;
        termguicolors = true;
        completeopt = ["menu" "noselect"];
      };

      colorschemes = {
        gruvbox-material-nvim.enable = true;
      };

      diagnostic = {
        settings = {
          virtual_text = true;
          virtual_lines = {
            current_line = true;
          };
        };
      };
    };
  };
}
