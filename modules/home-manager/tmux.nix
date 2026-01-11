{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    shortcut = "a";
    extraConfig = ''
      bind -r g popup -d '#{pane_current_path}' -E -w 90% -h 90% lazygit
    '';
    plugins = with pkgs; [
      tmuxPlugins.sensible
      {
        plugin = tmuxPlugins.gruvbox;
        extraConfig = ''
          set -g @tmux-gruvbox "dark" # Options: dark, dark256, light, light256
          set -g @tmux-gruvbox-right-status-x "Split"
          set -g @tmux-gruvbox-right-status-y "Screen"
          set -g @tmux-gruvbox-right-status-z "Magic  "
        '';
      }
      {
        plugin = tmuxPlugins.vim-tmux-navigator;
        extraConfig = ''
          bind C-z send-keys 'C-l'
        '';
      }
      tmuxPlugins.pain-control
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '10' # minutes
        '';
      }
    ];
  };
}
