#szh.nix
{ config, pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
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
        src = ./configs;
        file = "p10k.zsh";
      }
    ];
    shellAliases = {
      #nv = "NVIM_APPNAME=NvLazy nvim";
      nv = "NVIM_APPNAME=NvLazy appimage-run ~/.dotfiles/home-manager/apps/bin/nvim.appimage";
	    lv = "lvim";
    };
    # PNPM SETUP
    sessionVariables = {
      PNPM_HOME = "/home/yurgo/.pnpm-global";
      };
    initExtra = ''
      bindkey '^f' autosuggest-accept
      export PATH="$PNPM_HOME:$PATH"
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
