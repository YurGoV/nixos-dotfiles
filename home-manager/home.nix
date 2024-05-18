{ config, pkgs, ... }:

{
  imports = [
    ./apps/zsh.nix
    ./apps/alacritty.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "yurgo";
  home.homeDirectory = "/home/yurgo";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    btop
    nodejs_20
    nodePackages.pnpm
    telegram-desktop
    obsidian
    #git
    lazygit
    google-chrome
    fira-code-nerdfont
    alacritty
    alacritty-theme
    gcc
    gnumake
    shfmt
    stylua
    ripgrep
    fd
    fzf
    vimPlugins.luasnip
    unzip
    wget
    markdownlint-cli
    xclip
    python311Packages.pynvim
    tree-sitter
    docker
    mongodb-compass
    zsh-powerlevel10k
    # LUNARVIM
    lunarvim
    #neovim
    #python311Packages.flake8
    appimage-run
  ];


  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  programs.neovim = {
      enable = true;
      plugins = [ pkgs.vimPlugins.luasnip ];
      extraLuaPackages = ps: [ ps.jsregexp ];
  };
  programs.git = {
    enable = true;
    userName  = "Yuriy";
    userEmail = "yurgov@gmail.com";
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/yurgo/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    NIXPKGS_ALLOW_UNFREE = 1;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager = {
  enable = true;
  };
}
