{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.epark.development.nixvim;
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
  ];

  options = {
    epark.development.nixvim.enable = lib.mkEnableOption "Enable NeoVim";
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

    epark.development.nixvim.extra-config.enable = true;
    epark.development.nixvim.lsp.enable = true;
    epark.development.nixvim.keymaps.enable = true;
    epark.development.nixvim.opts.enable = true;
    epark.development.nixvim.globals.enable = true;
    epark.development.nixvim.plugins.enable = true;
    epark.development.nixvim.highlight.enable = true;
    epark.development.nixvim.files.enable = true;

    programs.nixvim = {
      enable = true;
      nixpkgs.source = pkgs.path;
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
