#home-laptop.nix
{ pkgs, ... }:
let
  unstable = import (builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") { };

#add 'in' for unstable neovim
in {
#{
  imports = [
    ./apps/configs/shells/zsh.nix
    ./apps/configs/terminals/alacritty.nix
    ./apps/configs/waybar/waybar.nix
    ./apps/configs/waybar/wlogout.nix
    ./apps/configs/terminals/kitty.nix
    ./apps/configs/terminals/tmux.nix
    ./apps/configs/swaylock.nix
    ./apps/configs/mongodb/mongosh.nix
    ./apps/configs/wofi/wofi.nix
    ./apps/configs/vifm/vifm.nix
    ./apps/configs/yazi/yazi.nix
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
  home.stateVersion = "24.05"; # Please read the comment before changing.



  home.packages = with pkgs; [
    btop
    nodejs_22
    nodePackages.pnpm
    obsidian
    killall
    # vifm-full
    pcmanfm
    #git
    glab
    lazygit
    google-chrome
    firefox
    fira-code-nerdfont
    alacritty
    alacritty-theme
    kitty
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
    # xclip
    wl-clipboard
    tree-sitter
    # docker
    postman
    mongodb-compass
    zsh-powerlevel10k
    # LUNARVIM
    # lunarvim
    #??? not work
    # luaPackages.jsregexp
    # vimPlugins.luasnip
    #??? not work
    #neovim
    (unstable.neovim.override { vimAlias = true; })
    # vimPlugins.neodev-nvim
    # ! cargo is in rustup. uncomment if remove rustup
    # cargo
    jq #for kula rest api tester response parse
    tree-sitter
    lua51Packages.lua
    luarocks
    python3
    python311Packages.pynvim
    #python311Packages.flake8
    appimage-run
    # for hyprland
    waybar
    pavucontrol
    networkmanager
    # wofi
    hyprpaper
    pipewire
    wireplumber
    # xdg-desktop-portal-hyprland
    # wlogout
    # communication
    slack
    telegram-desktop
    zoom-us
    #OFFICE
    onlyoffice-bin
    masterpdfeditor
    # screen capture
    grim
    swappy
    slurp
    gpu-screen-recorder
    simplescreenrecorder
    wf-recorder
    ffmpeg_5-full
    opusTools
    sox
    # linux console utils
    ncdu
    bat
    fd
    eza
    parallel
    ## video
    glxinfo
    vdpauinfo
    radeontop
    amdgpu_top
    lightworks
    # blender-hip
    (unstable.blender-hip.override {})
    vlc
    davinci-resolve
    ## shell utils
    eza
    ## phone utils
    jmtpfs
    pandoc
    glow
    # MySQL
    mysql
    # for prisma
    direnv
    openssl_3_3
    rustup
    protobuf
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

  # programs.tmux = {
  #   enable = true;
  #   terminal = "tmux-256color";
  #   extraConfig = ''
  #     set-option -ga terminal-overrides ",*256col*:Tc:RGB"
  #   '';
  # };

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
    NIXPKGS_ALLOW_INSECURE=1;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager = {
    enable = true;
  };
}
