{
  config,
  lib,
  ...
}: let
  cfg = config.epark.nvim.plugins.language-support;
in {
  imports = [];

  options = {
    epark.nvim.plugins.language-support.enable = lib.mkEnableOption "Enable NeoVim Plugins for Language Support";
  };

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      plugins = {
        conform-nvim = {
          enable = true;
          settings = {
            formatters_by_ft = {
              nix = ["alejandra"];
              ruby = ["rubyfmt"];
              css = ["prettier"];
            };
            format_on_save = {
              lsp_format = "fallback";
              timeout_ms = 500;
            };
          };
        };
        treesitter = {
          enable = true;
          settings = {
            auto_install = true;
          };
        };
        luasnip.enable = true;
      };
    };
  };
}
