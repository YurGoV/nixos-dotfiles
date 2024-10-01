# tmuxifier.nix
{ config, pkgs, ... }:

{
  home.file.".tmuxifier" = {
    recursive = true;
    source = "${pkgs.tmuxifier}/share/tmuxifier";  # Use the installed Tmuxifier
    sessionsDir = "${config.home.homeDirectory}/.dotfiles/home-manager/apps/configs/terminals/tmuxifier-sessions"; # Custom directory for session files
  };

  # home.file.".tmuxifier/layouts" = {
  #   recursive = true;
  #   source = /home/${builtins.getEnv "USER"}/.dotfiles/home-manager/apps/configs/terminals/tmuxifier-sessions;
  #   sessionsDir = "${config.home.homeDirectory}/.dotfiles/home-manager/apps/configs/terminals/tmuxifier-sessions"; # Custom directory for session files    sessionsDir = "${config.home.homeDirectory}/.dotfiles/home-manager/apps/configs/terminals/tmuxifier-sessions"; # Custom directory for session files
  # };
}

# { config, pkgs, lib, ... }:
#
# {
#   # Enable Tmuxifier
#   programs.tmuxifier = {
#     enable = true;  # Enable Tmuxifier
#     # You can add additional configuration options here if needed
#     # sessionsDir = "${config.home.homeDirectory}/.dotfiles/home-manager/apps/configs/terminals/tmuxifier-sessions"; # Custom directory for session files
#   };
# }
#
