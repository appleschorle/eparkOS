{inputs}: {
  imports = [
    ./browser/firefox.nix
    ./desktop/cursor.nix
    ./desktop/discord.nix
    ./desktop/dunst.nix
    ./desktop/hyprland
    ./desktop/icon-pack.nix
    ./development/direnv.nix
    ./development/git.nix
    ./development/lazygit.nix
    ./development/ruby.nix
    ./terminal/kitty.nix
    ./terminal/tmux
    ./terminal/xdg-user.nix
    ./terminal/zoxide.nix
    ./terminal/zsh.nix
    inputs.nixvim.homeModules.nixvim
    ./development/nixvim
  ];
}
