{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
with lib; {
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  options.myNvim.enable = mkEnableOption "Enable NeoVim";

  config = mkIf config.myNvim.enable {
    home.packages = with pkgs; [
      alejandra
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
        lua_ls = {
          enable = true;
        };
      };
      colorschemes.gruvbox-material-nvim.enable = true;
      plugins.oil.enable = true;
      plugins.treesitter = {
        enable = true;
        settings = {
          auto_install = true;
        };
      };
      plugins.lualine.enable = true;
      plugins.conform-nvim.enable = true;
      plugins.conform-nvim.settings = {
        formatters_by_ft = {
          nix = ["alejandra"];
        };
        format_on_save = {
          lsp_format = "fallback";
          timeout_ms = 500;
        };
      };
    };
  };
}
