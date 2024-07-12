{ config, pkgs, lib, ... }:

# added for unstable neovim
let
  unstable = import (builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") { };

#add 'in' for unstable neovim
in {
# {
  imports = [
    ./apps/configs/shells/zsh.nix
    ./apps/configs/termilals/alacritty.nix
    ./apps/configs/waybar/waybar.nix
    ./apps/configs/waybar/wlogout.nix
    ./apps/configs/termilals/kitty.nix
    ./apps/configs/termilals/tmux.nix
    ./apps/configs/swaylock.nix
    ./apps/configs/mongodb/mongosh.nix
    ./apps/configs/wofi/wofi.nix
    ./apps/configs/vifm/vifm.nix
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


  # wayland.windowManager.hyprland.enable = true;
  # wayland.windowManager.hyprland.settings = {
  #   "$mod" = "SUPER";
  #   bind =
  #     [
  #       "$mod, F, exec, firefox"
  #       ", Print, exec, grimblast copy area"
  #     ]
  #     ++ (
  #       # workspaces
  #       # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
  #       builtins.concatLists (builtins.genList (
  #           x: let
  #             ws = let
  #               c = (x + 1) / 10;
  #             in
  #               builtins.toString (x + 1 - (c * 10));
  #           in [
  #             "$mod, ${ws}, workspace, ${toString (x + 1)}"
  #             "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
  #           ]
  #         )
  #         10)
  #     );

  # wayland.windowManager.hyprland.settings = {
  #   decoration = {
  #     shadow_offset = "0 5";
  #     "col.shadow" = "rgba(00000099)";
  #   };
  #
  #   "$mod" = "SUPER";
  #
  #   bindm = [
  #     # mouse movements
  #     "$mod, mouse:272, movewindow"
  #     "$mod, mouse:273, resizewindow"
  #     "$mod ALT, mouse:272, resizewindow"
  #   ];
  # };

  ## added for unstable neovim
  # nixpkgs.overlays = [
  #   (self: super: {
  #     neovim = unstable.neovim.override { # We're overriding with the unstable package
  #       vimAlias = true;
  #     };
  #   })
  # ];

  home.packages = with pkgs; [
    btop
    nodejs_22
    nodePackages.pnpm
    obsidian
    killall
    # vifm-full
    pcmanfm
    #git
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
    unzip
    wget
    # xclip
    wl-clipboard
    # python311Packages.pynvim
    # docker
    mongodb-compass
    zsh-powerlevel10k
    # LUNARVIM
    lunarvim
    python312Packages.pip
    python3
    cargo
    #??? not work
    # luaPackages.jsregexp
    # vimPlugins.luasnip
    #??? not work
    # neovim
    (unstable.neovim.override { vimAlias = true; })
    # vimPlugins.neodev-nvim
    tree-sitter
    lua51Packages.lua
    luarocks
    viu
    chafa
    ueberzugpp
    # vimPlugins.cmp_luasnip
    # lua
    # vimPlugins.luasnip
    # vimPlugins.vim-markdown-toc
    # vimPlugins.luasnip
    # markdownlint-cli
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
    telegram-desktop
    zoom-us
    #OFFICE
    onlyoffice-bin
    # screen capture
    grim
    swappy
    slurp
    gpu-screen-recorder
    simplescreenrecorder
    wf-recorder
    # linux console utils
    ncdu
    bat
    fd
    eza
    #helix
    nil
    nixpkgs-fmt
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

  # programs.neovim = {
  #   enable = true;
  #   # package = pkgs.neovim;
  #   plugins = [ pkgs.vimPlugins.luasnip pkgs.vimPlugins.cmp_luasnip pkgs.vimPlugins.nvim-treesitter.withAllGrammars ];
  #   extraLuaPackages = ps: [ ps.jsregexp ];
  # };
  programs.helix = {
    enable = true;
    settings = {
      theme = "autumn_night_transparent";
      editor.cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
      };
    };
    # tree-sitter = {
    #     ensure_installed = [
    #       "typescript"
    #       "tsx"
    #       "json"
    #       "jsonc"
    #       "vue"
    #       "nix"
    #     ];
    #   };
    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter = { command = "nixpkgs-fmt"; };
        # formatter.command = "${pkgs.nixfmt-classic}/bin/nixfmt";
      }
      {
        name = "typescript";
        formatter = { command = "prettier"; args = [ "--parser" "typescript" ]; };
        auto-format = true;
      }
      {
        name = "json";
        formatter = { command = "prettier"; args = [ "--parser" "json" ]; };
        auto-format = true;
      }
      {
        name = "vue";
        auto-format = true;
        formatter = { command = "prettier"; args = [ "--parser" "vue" ]; };
        language-servers = [ "typescript-language-server" ];
        #added to test:
        injection-regex = "vue";
        scope = "source.vue";
        file-types = ["vue"];
        roots = ["package.json"];
      }
    ];
    languages.language-server.typescript-language-server.config.plugins = [
      {
        name = "@vue/typescript-plugin";
        location = "/home/yurgo/.pnpm-global/5/node_modules/@vue/language-server/";
        # location = <path to "node_modules/@vue/language-server/">
        languages = ["vue"];
      }
    ];
    # extraConfig = builtins.toFile "languages.toml" ''
    #   [[language]]
    #   name = "vue"
    #   auto-format = true
    #   formatter = { command = "prettier", args = ["--parser", "vue"] }
    #   language-servers = ["typescript-language-server"]
    #
    #   [[language-server.typescript-language-server.config.plugins]]
    #   name = "@vue/typescript-plugin"
    #   location = "/home/yurgo/.pnpm-global/5/node_modules/@vue/language-server/"
    #   languages = ["vue"]
    # '';
    # language-server = {
    #     typescript = {
    #       command = "${pkgs.typescript-language-server}/bin/typescript-language-server";
    #       args = ["--stdio"];
    #       root-patterns = ["package.json" "tsconfig.json" ".git"];
    #       filetypes = ["typescript" "typescriptreact" "vue"];
    #       settings = {
    #         plugins = [
    #           {
    #             name = "@vue/typescript-plugin";
    #             location = "/home/yurgo/.pnpm-global/5/node_modules/@vue/language-server/";
    #             languages = ["vue"];
    #           }
    #         ];
    #       };
    #     };
    #   };
    themes = {
      autumn_night_transparent = {
        "inherits" = "autumn_night";
        "ui.background" = { };
      };
    };
  };
  # programs.git = {
  #   enable = true;
  #   userName  = "yurgov";
  #   userEmail = "yurgov@gmail.com";
  # };

  # keyring - not work
  # services.gnome.gnome-keyring.enable = true; #???
  # security.pam.services.sddm.enableGnomeKeyring = true;

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
    NIXPKGS_ALLOW_INSECURE = 1;
    ## added for unstable neovim
    PATH = lib.makeBinPath [
      pkgs.neovim
      # Add other necessary paths here if needed
    ];
  };

  # Let Home Manager install and manage itself.
  programs.home-manager = {
    enable = true;
  };
}
