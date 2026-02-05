{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.epark.tmux;
in {
  options.epark.tmux.enable = lib.mkEnableOption "Enable Tmux";

  config = lib.mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      shortcut = "a";
      sensibleOnTop = true;
      extraConfig = ''
        set -g default-command "${pkgs.reattach-to-user-namespace}/bin/reattach-to-user-namespace ${pkgs.zsh}/bin/zsh" # This is needed because tmux sensible uses $SHELL which points to /bin/sh in nix
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
            bind C-l send-keys 'C-l'
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
  };
}
