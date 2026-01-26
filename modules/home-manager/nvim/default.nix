{
  pkgs,
  inputs,
  config,
  lib,
  ...
}: let
  cfg = config.epark.nvim;
in {
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./extra-config.nix
    ./lsp.nix
    ./keymaps.nix
    ./options.nix
    ./globals.nix
    ./plugins
    ./highlight.nix
  ];

  options = {
    epark.nvim.enable = lib.mkEnableOption "Enable NeoVim";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      alejandra
      prettier
      ruby
      # rubyfmt
      gcc
      gnumake
      pkg-config
      shellcheck
      shfmt
    ];

    epark.nvim.extra-config.enable = true;
    epark.nvim.lsp.enable = true;
    epark.nvim.keymaps.enable = true;
    epark.nvim.opts.enable = true;
    epark.nvim.globals.enable = true;
    epark.nvim.plugins.enable = true;
    epark.nvim.highlight.enable = true;

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
    };
  };
}
