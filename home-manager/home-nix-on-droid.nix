{ config, lib, pkgs, ... }:
{
 # Read the changelog before changing this value
  home.stateVersion = "24.05";
  home.packages = with pkgs; [
    htop
  ];
  programs.zsh = {
    enable = true;
    #interactiveShellInit = ''
    #export EDITOR="nvim"
    ##export NIXPKGS_ALLOW_UNFREE=1
    #export NIXPKGS_ALLOW_INSECURE=1
    #'';
    #default = true;
  };
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
