{
  pkgs,
  inputs,
  config,
  lib,
  ...
}: let
  cfg = config.epark.nvim;
  nixvimModule = inputs.nixvim.homeModules.nixvim;
in
  with lib; {
    imports = [
      nixvimModule
    ];

    options.epark.nvim.enable = mkEnableOption "Enable NeoVim";

    config = mkIf cfg.enable {
      home.packages = with pkgs; [
        alejandra
        ruby
        rubyfmt
        gcc
        gnumake
        pkg-config
      ];

      programs.nixvim = {
        enable = true;

        defaultEditor = true;

        viAlias = true;
        vimAlias = true;

        dependencies = {
          ripgrep.enable = true;
          gcc.enable = true;
          tree-sitter.enable = true;
          nodejs.enable = true;
        };

        keymaps = [
          {
            action = "<cmd>Oil<CR>";
            key = "-";
            mode = "n";
            options.desc = "Open parent directory with Oil";
          }
        ];

        lsp.servers = {
          "*" = {
            config = {
              capabilities = {
                textDocument = {
                  semanticTokens = {
                    multilineTokenSupport = true;
                  };
                };
              };
              root_markers = [
                ".git"
              ];
            };
          };
          clangd = {
            config = {
              cmd = [
                "clangd"
                "--background-index"
              ];
              filetypes = [
                "c"
                "cpp"
              ];
              root_markers = [
                "compile_commands.json"
                "compile_flags.txt"
              ];
            };
            enable = true;
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
              cmd = ["bundle" "exec" "ruby-lsp"];
              filetypes = ["ruby"];
              root_markers = ["Gemfile" "Gemfile.lock"];
            };
          };
          lua_ls = {
            enable = true;
          };
        };

        colorschemes.gruvbox-material-nvim.enable = true;

        plugins = {
          nvim-autopairs.enable = true;
          todo-comments.enable = true;
          web-devicons.enable = true;
          render-markdown.enable = true;
          telescope.enable = true;
          nvim-surround.enable = true;
          oil.enable = true;
          trouble.enable = true;
          undotree.enable = true;
          which-key.enable = true;
          visual-whitespace.enable = true;
          lualine.enable = true;
          blink-cmp.enable = true;
          luasnip.enable = true;
          treesitter = {
            enable = true;
            settings = {
              auto_install = true;
            };
          };
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
                show_exact_scope = true;
                show_start = true;
              };
            };
          };
          conform-nvim = {
            enable = true;
            settings = {
              formatters_by_ft = {
                nix = ["alejandra"];
                ruby = ["rubyfmt"];
              };
              format_on_save = {
                lsp_format = "fallback";
                timeout_ms = 500;
              };
            };
          };
        };
      };
    };
  }
