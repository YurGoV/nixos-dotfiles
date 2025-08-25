# home-manager/home-wsl.nix
{ pkgs, ... }:

{
  # Імпортуємо всі ваші термінальні налаштування!
  imports = [
    ./apps/configs/shells/zsh.nix
    ./apps/configs/terminals/alacritty.nix # Налаштування знадобляться для Windows Terminal
    ./apps/configs/terminals/kitty.nix
    ./apps/configs/terminals/tmux.nix
    ./apps/configs/mongodb/mongosh.nix
    ./apps/configs/vifm/vifm.nix
    ./apps/configs/yazi/yazi.nix
  ];

  home.username = "yurgo";
  home.homeDirectory = "/home/yurgo";
  home.stateVersion = "24.05";

  # Список пакетів ТІЛЬКИ для терміналу
  home.packages = with pkgs; [
    # Dev tools
    btop
    nodejs_22
    nodePackages.pnpm
    killall
    docker
    docker-compose
    glab
    lazygit
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
    tree-sitter
    zsh-powerlevel10k
    lua51Packages.lua
    luarocks
    python3
    python311Packages.pynvim
    opusTools
    sox
    appimage-run
    rustup
    dotnet-sdk
   
    tmuxifier    
    # Console utils
    ncdu
    mc
    git
    eza
    parallel
    bat
    fastfetch

    mariadb
    

    openssl_3
    protobuf
    rclone
    # Ваші налаштування Neovim (NvLazy)
    neovim
  ];

  #xdg.configFile."NvLazy" = {
  #  source = ./apps/configs/NvLazy;
  #  recursive = true; # Важливо для копіювання/посилання на цілу теку
  #};
  xdg.configFile = {
    # Окремі файли з кореня вашої конфігурації NvLazy
    "NvLazy/init.lua".source = ./apps/configs/NvLazy/init.lua;
    ##"NvLazy/lazyvim.json".source = ./apps/configs/NvLazy/lazyvim.json;
    "NvLazy/stylua.toml".source = ./apps/configs/NvLazy/stylua.toml;
    "NvLazy/README.md".source = ./apps/configs/NvLazy/README.md;
    "NvLazy/LICENSE".source = ./apps/configs/NvLazy/LICENSE;

    # І вся тека 'lua' з усім вмістом
    "NvLazy/lua" = {
      source = ./apps/configs/NvLazy/lua;
      recursive = true;
    };
  };

  # Ваші змінні середовища
  home.sessionVariables = {
    EDITOR = "nvim";
    NIXPKGS_ALLOW_UNFREE = 1;
  };

  # Вмикаємо Home Manager
  programs.home-manager.enable = true;
}
