{ config, lib, pkgs, ... }:
let
  unstable = import (builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") { };
#add 'in' for unstable neovim
in {
 # Read the changelog before changing this value
  home.stateVersion = "24.05";


  imports = [
    ./apps/configs/shells/zsh.nix
    ./apps/configs/terminals/tmux.nix
  ];

  home.packages = with pkgs; [
    htop
    (unstable.neovim.override { vimAlias = true; })
    zsh-powerlevel10k
    direnv
    tmuxifier
  ];
  # programs.zsh = {
  #   enable = true;
  #   ##interactiveShellInit = ''
  #   ##export EDITOR="nvim"
  #   ###export NIXPKGS_ALLOW_UNFREE=1
  #   ##export NIXPKGS_ALLOW_INSECURE=1
  #   ##'';
  #   ##default = true;
  # };
  home.sessionVariables = {
    EDITOR = "nvim";
    NIXPKGS_ALLOW_UNFREE = 1;
    NIXPKGS_ALLOW_INSECURE=1;
  };
  #home.defaultShell = pkgs.zsh;

  # insert home-manager config
  # Let Home Manager install and manage itself.
  programs.home-manager = {
    enable = true;
  };
}
