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
    ./extra-config.nix
    ./files.nix
    ./globals.nix
    ./highlight.nix
    ./keymaps.nix
    ./lsp.nix
    ./options.nix
    ./plugins
    inputs.nixvim.homeModules.nixvim
  ];

  options = {
    epark.nixvim.enable = lib.mkEnableOption "Enable NeoVim";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      alejandra
      prettier
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
