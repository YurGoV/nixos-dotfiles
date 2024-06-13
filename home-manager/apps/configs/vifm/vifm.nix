{pkgs, ...}: let
  # configDir = "~/.dotfiles/home-manager/apps/configs/vifm/config/";
   # configDir = ./home-manager/apps/configs/vifm/config;
   configDir = ./config;
in {
  home.packages = with pkgs; [
    vifm-full
  ];

  home.sessionVariables = {
    VIFM = configDir;
    MYVIFMRC = "${configDir}/vifmrc";
  };

  xdg.configFile."vifm" = {
    source = configDir;
    # source = ./vifm;
    recursive = true;
  };
}
