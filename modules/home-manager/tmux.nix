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
      mouse = true;
      shortcut = "a";
      sensibleOnTop = true;
      extraConfig = ''
        # This is needed because tmux sensible uses $SHELL which points to /bin/sh in nix
        set -g default-command "${pkgs.reattach-to-user-namespace}/bin/reattach-to-user-namespace ${pkgs.zsh}/bin/zsh"

        ### Copy mode navigation ###
        setw -g mode-keys vi

        ### Lazygit popup ###
        bind -r g popup -d '#{pane_current_path}' -E -w 90% -h 90% lazygit
      '';
      # TODO: Set up tmux properly with vim https://github.com/christoomey/vim-tmux-navigator
      plugins = with pkgs; [
        {
          plugin = tmuxPlugins.gruvbox;
          extraConfig = ''
            set -g @tmux-gruvbox "dark" # Options: dark, dark256, light, light256
            set -g @tmux-gruvbox-right-status-x "Split"
            set -g @tmux-gruvbox-right-status-y "Screen"
            set -g @tmux-gruvbox-right-status-z "Magic  "
          '';
        }
        # {
        #   plugin = tmuxPlugins.vim-tmux-navigator;
        #   extraConfig = ''
        #     bind C-z send-keys 'C-l'
        #   '';
        # }
        tmuxPlugins.pain-control
      ];
    };
  };
}
