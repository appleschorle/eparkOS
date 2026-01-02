{
  config,
  lib,
  pkgs,
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
            highlight.enable = true;
            indent.enable = true;
            folding.enable = true;
            incremental_selection.enable = true;
          };
          grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
            css
            bash
            json
            lua
            make
            markdown
            nix
            regex
            toml
            vim
            vimdoc
            xml
            yaml
            ruby
          ];
        };
        luasnip.enable = true;
      };
    };
  };
}
