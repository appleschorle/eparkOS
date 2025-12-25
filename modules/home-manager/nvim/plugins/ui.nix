{
  config,
  lib,
  ...
}: let
  cfg = config.epark.nvim.plugins.ui;
in {
  imports = [];

  options = {
    epark.nvim.plugins.ui.enable = lib.mkEnableOption "Enable NeoVim Plugins for UI";
  };

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      plugins = {
        indent-blankline = {
          enable = true;
          settings = {
            exclude = {
              buftypes = [
                "terminal"
                "quickfix"
              ];
              filetypes = [
                ""
                "checkhealth"
                "help"
                "lspinfo"
                "packer"
                "TelescopePrompt"
                "TelescopeResults"
              ];
            };
            indent = {
              char = "│";
            };
            scope = {
              show_end = true;
              highlight = "IblScope";
              show_exact_scope = true;
              show_start = true;
            };
          };
        };
        lualine.enable = true;
        web-devicons.enable = true;
        visual-whitespace.enable = true;
        render-markdown.enable = true;
      };
    };
  };
}
