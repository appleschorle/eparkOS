{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.epark.nvim.lsp;
in {
  imports = [];

  options = {
    epark.nvim.lsp.enable = lib.mkEnableOption "Enable NeoVim LSP";
  };

  config = lib.mkIf cfg.enable {
    programs.nixvim.lsp.servers = {
      "*" = {
        config = {
          capabilities.textDocument.semanticTokens.multilineTokenSupport = true;
          root_markers = [".git"];
        };
      };

      clangd = {
        enable = true;
        config = {
          cmd = ["clangd" "--background-index"];
          filetypes = ["c" "cpp"];
          root_markers = ["compile_commands.json" "compile_flags.txt"];
        };
      };

      nixd = {
        enable = true;
        config = {
          cmd = ["nixd"];
          filetypes = ["nix"];
          root_markers = ["flake.nix" "flake.json"];
        };
      };

      ruby_lsp = {
        enable = true;
        config = {
          cmd = ["solargraph" "stdio"];
          filetypes = ["ruby"];
          root_markers = ["Gemfile" "Gemfile.lock"];
        };
      };

      cssls = {
        enable = true;
        config = {
          cmd = ["vscode-css-language-server" "--stdio"];
          filetypes = ["css"];
          root_markers = ["index.html" "index.css" "index.js" ".git"];
        };
      };

      bashls = {
        enable = true;
        config = {
          cmd = ["bash-language-server" "start"];
          filetypes = ["bash" "sh"];
          root_markers = [".git"];
        };
      };

      lua_ls = {
        enable = true;
        config = {
          cmd = ["lua-language-server"];
          filetypes = ["lua"];
          root_markers = [".luarc.json" ".luarc.jsonc" ".git" "init.lua"];
          settings = {
            Lua = {
              runtime = {
                version = "LuaJIT";
              };

              # IMPORTANT: cannot call vim.api in Nix
              # use fixed paths instead
              workspace = {
                library = [
                  "${pkgs.neovim}/share/nvim/runtime"
                ];
              };

              diagnostics = {
                globals = ["vim"];
              };

              completion = {
                callSnippet = "Replace";
                keywordSnippet = "Replace";
              };

              hint = {
                enable = true;
              };
            };
          };
        };
      };
    };
  };
}
