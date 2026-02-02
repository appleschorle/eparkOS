{
  pkgs,
  inputs,
  config,
  lib,
  ...
}: let
  cfg = config.epark.nixvim;
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
    ./files.nix
  ];

  options = {
    epark.nixvim.enable = lib.mkEnableOption "Enable NeoVim";
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

    epark.nixvim.extra-config.enable = true;
    epark.nixvim.lsp.enable = true;
    epark.nixvim.keymaps.enable = true;
    epark.nixvim.opts.enable = true;
    epark.nixvim.globals.enable = true;
    epark.nixvim.plugins.enable = true;
    epark.nixvim.highlight.enable = true;
    epark.nixvim.files.enable = true;

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
