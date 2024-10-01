# tmuxifier.nix
{ config, pkgs, ... }:

{
  home.file.".tmuxifier" = {
    recursive = true;
    source = "${pkgs.tmuxifier}/share/tmuxifier";  # Use the installed Tmuxifier
    # sessionsDir = "${config.home.homeDirectory}/.dotfiles/home-manager/apps/configs/terminals/tmuxifier-sessions"; # Custom directory for session files
  };

}
