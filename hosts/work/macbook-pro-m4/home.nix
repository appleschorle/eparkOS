{
  flakeRootPath,
  inputs,
  ...
}: {
  imports = [
    "${flakeRootPath}/modules/home-manager/development/direnv.nix"
    "${flakeRootPath}/modules/home-manager/development/lazygit.nix"
    "${flakeRootPath}/modules/home-manager/development/nixvim"
    "${flakeRootPath}/modules/home-manager/terminal/kitty.nix"
    "${flakeRootPath}/modules/home-manager/terminal/tmux"
    "${flakeRootPath}/modules/home-manager/terminal/zoxide.nix"
    ./home-manager/browser/firefox.nix
    ./home-manager/development/git.nix
    ./home-manager/terminal/zsh.nix
  ];

  config = {
    home = {
      username = "eugenepark";
      homeDirectory = "/Users/eugenepark";
      stateVersion = "25.05";
      sessionPath = [
        "/opt/homebrew/opt/ruby@3.3/bin"
        "/opt/homebrew/lib/ruby/gems/3.3.0/bin"
        "/opt/homebrew/bin"
        "/opt/homebrew/sbin"
        "$HOME/.local/bin"
        "$HOME/repos/gdk/bin"
        "/Applications/Rancher Desktop.app/Contents/Resources/resources/darwin/bin"
      ];
    };
    programs.home-manager.enable = true;

    nixpkgs.config.allowUnfree = true;

    colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-hard;

    epark = {
      development.nixvim.enable = true;
      development.lazygit.enable = true;
      development.direnv.enable = true;
      terminal.tmux.enable = true;
      terminal.zoxide.enable = true;
      terminal.kitty.enable = true;
    };
  };
}
