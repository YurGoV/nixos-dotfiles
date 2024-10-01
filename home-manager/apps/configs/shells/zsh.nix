#szh.nix
{ config, pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion = {
        enable = true;
    };
    # enableAutosuggestions = true;
    syntaxHighlighting = {
      enable = true;
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "node" "npm" "history" "docker-compose" "docker" ];
      theme = "dst";
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./zsh-powerlewel9k-config;
        file = "p10k.zsh";
      }
    ];

    shellAliases = {
      #nv = "NVIM_APPNAME=NvLazy nvim";
      nvv = "NVIM_APPNAME=NvLazy appimage-run ~/.dotfiles/home-manager/apps/bin/nvim.appimage";
      nv = "NVIM_APPNAME=NvLazy nvim";
      lv = "NVIM_APPNAME=lvim appimage-run ~/.dotfiles/home-manager/apps/bin/nvim.appimage";
      lw = "DRI_PRIME=1 lightworks-2023.1";
      # cn = "DRI_PRIME=1 appimage-run ~/progs/cinelerra/CinGG-20220928-x86_64.AppImage";
	    # lv = "lvim";
      monitors-toggle = "~/.dotfiles/scripts/hyprland/monitors-toggle";
      np = "swpm";
      screen-recording = "~/.dotfiles/scripts/diff/screen-recording";
      reencode-screen-record = "~/.dotfiles/scripts/diff/reencode-screen-record";
      # run psql util temporary
      psql="nix shell nixpkgs#postgresql --command psql";
      mountusb="sudo mount -t vfat /dev/sdb /home/yurgo/mnt -o uid=$(id -u yurgo),gid=$(id -g yurgo),umask=0022";
      yy = "yazi";
      osync = "cd ~/Documents/obsidian/ && git add . && git commit -m 'current' && git push && rclone bisync ~/Documents/obsidian pcloud:/obsidian";
    };
    # PNPM SETUP
    sessionVariables = {
        PNPM_HOME = "/home/yurgo/.pnpm-global";
        ZSH_TMUX_CONFIG = "$HOME/.config/tmux/tmux.conf";
      };
    initExtra = ''
      # Set Zsh option to ignore commands starting with a space
      setopt HIST_IGNORE_SPACE
      bindkey '^f' autosuggest-accept
      export PATH="$PNPM_HOME:$PATH"
      export PATH="$HOME/.npm-global/bin:$PATH"
      eval "$(direnv hook zsh)"
      export TMUXIFIER_LAYOUT_PATH="$HOME//.dotfiles/home-manager/apps/configs/terminals/tmuxifier-sessions"
      eval "$(tmuxifier init -)"
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
