# tmux.nix
{ config, pkgs, ... } :

let
  # Thanks: https://github.com/DanielFGray/dotfiles/blob/master/tmux.remote.conf
  remoteConf = builtins.toFile "tmux.remote.conf" ''
    unbind C-q
    unbind q
    set-option -g prefix C-j
    bind s send-prefix
    bind C-j last-window
    set-option -g status-position top
  '';
in {

  imports = [
    ./tmux.theme.nix
    # ./tmuxifier.nix
  ];

  programs.tmux = {
    enable = true;
    shortcut = "q";
    escapeTime = 10;
    keyMode = "vi";
    terminal = "tmux-256color";
    historyLimit = 50000;

    extraConfig = with config.theme; with pkgs.tmuxPlugins;
    # extraConfig = with pkgs.tmuxPlugins;
    ''
      # Plugins
      run-shell '${copycat}/share/tmux-plugins/copycat/copycat.tmux'
      run-shell '${sensible}/share/tmux-plugins/sensible/sensible.tmux'
      run-shell '${urlview}/share/tmux-plugins/urlview/urlview.tmux'

      bind-key R run-shell ' \
        tmux source-file /etc/tmux.conf > /dev/null; \
        tmux display-message "sourced /etc/tmux.conf"'

      # Apply remoteConf settings globally
      unbind C-q
      unbind q
      set-option -g prefix C-j
      bind s send-prefix
      bind C-j last-window
      set-option -g status-position bottom

      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R

      if -F "$SSH_CONNECTION" "source-file '${remoteConf}'"

      set-option -g status-right ' #{prefix_highlight} "#{=21:pane_title}" %H:%M %d-%b-%y'
      set-option -g status-left-length 20
      set-option -g @prefix_highlight_fg '${colors.background}'
      set-option -g @prefix_highlight_bg '${colors.dominant}'
      run-shell '${prefix-highlight}/share/tmux-plugins/prefix-highlight/prefix_highlight.tmux'

      # Be faster switching windows
      bind C-n next-window
      bind C-p previous-window

      # Send the bracketed paste mode when pasting
      bind ] paste-buffer -p

      set-option -g set-titles on

      bind C-y run-shell ' \
        ${pkgs.tmux}/bin/tmux show-buffer > /dev/null 2>&1 \
        && ${pkgs.tmux}/bin/tmux show-buffer | ${pkgs.xsel}/bin/xsel -ib'

      # Force true colors
      set-option -ga terminal-overrides ",*:Tc"

      set-option -g mouse on
      set-option -g focus-events on

      # Stay in same directory when split
      bind % split-window -h -c "#{pane_current_path}"
      bind '"' split-window -v -c "#{pane_current_path}"

      # Colorscheme
      set-option -g status-style 'fg=${colors.dimForeground}, bg=${colors.background}'

      set-option -g window-status-current-style 'fg=${colors.dominant}'

      set-option -g pane-border-style 'fg=${colors.background}'
      set-option -g pane-active-border-style 'fg=${colors.dominant}'

      set-option -g message-style 'fg=${colors.background}, bg=${colors.dimForeground}'

      set-option -g mode-style    'fg=${colors.background}, bg=${colors.dominant}'

      set-option -g display-panes-active-colour '${colors.dominant}'
      set-option -g display-panes-colour '${colors.dimForeground}'

      set-option -g clock-mode-colour '${colors.dominant}'
    '';
  };
}
