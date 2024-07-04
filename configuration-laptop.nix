{ config, pkgs, ... }:

{
  imports = [
      ./hardware-configuration-laptop.nix
    ];

  # kernelParams
  boot.initrd.kernelModules = [ "amdgpu" ];

  # BootParams
  boot.loader.systemd-boot.enable = false;

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;

  ## Powermanagement (for suspend & hibernate)
  powerManagement.enable = true;

  ## LAPTOP Configure
  # for intel spu-s (prevent overhiting)
  services.thermald.enable = true;
  services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 80;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 20;

       #Optional helps save long term battery health
       START_CHARGE_THRESH_BAT0 = 55; # 40 and bellow it starts to charge
       STOP_CHARGE_THRESH_BAT0 = 60; # 80 and above it stops charging

      };
  };


  networking.hostName = "laptop"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Kyiv";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "uk_UA.UTF-8";
    LC_IDENTIFICATION = "uk_UA.UTF-8";
    LC_MEASUREMENT = "uk_UA.UTF-8";
    LC_MONETARY = "uk_UA.UTF-8";
    LC_NAME = "uk_UA.UTF-8";
    LC_NUMERIC = "uk_UA.UTF-8";
    LC_PAPER = "uk_UA.UTF-8";
    LC_TELEPHONE = "uk_UA.UTF-8";
    LC_TIME = "uk_UA.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  #? Intel drivers
  services.xserver.videoDrivers = [ "amdgpu" ];
  

  # Enable the XFCE Desktop Environment.
  # !turn on if no awesome config
  # services.xserver.displayManager.lightdm.enable = false;
  # services.xserver.desktopManager.xfce.enable = true;

  # sddm for wyland experimental support
  ##services.xserver.displayManager.sddm.enable = true;
  ##services.xserver.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.enable = true;

  security.pam.services.swaylock = {};

  # Configure keymap in X11
  ##services.xserver.layout = "us,ua";
  ##services.xserver.xkbVariant = "";
  ##services.xserver.xkbOptions = "grp:rctrl_toggle";
  services.xserver.xkb.variant = "";
  services.xserver.xkb.options = "grp:rctrl_toggle";
  services.xserver.xkb.layout = "us,ua";


  # Enable CUPS to print documents.
  #services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  ## Enable bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.yurgo = {
    isNormalUser = true;
    description = "yurgo";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
    ];
  };

  # Install firefox.
  # programs.firefox.enable = true;


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Docker setup
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
  virtualisation.docker.daemon.settings = {
    data-root = "/home/yurgo/.docker-images";
  };

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
  xfce.xfce4-pulseaudio-plugin
  xfce.xfce4-systemload-plugin
  vim
  mc
  git
  # FOR HYPRLAND
  polkit
  dconf
  # TODO: move xwayland to home-manager
  xwayland
  #swaylock
  #swayidle
  wdisplays
  docker-compose
  docker
  #
  libva
  libvdpau-va-gl
  vaapiVdpau
  libvdpau-va-gl
  libva-utils
  ffmpeg_5-full
  ];

  # TODO: move xwayland to home-manager
  # wayland
  programs.hyprland = {
    # Install the packages from nixpkgs
    enable = true;
    # Whether to enable XWayland
    xwayland.enable = true;
  };
  #programs.sway = {
  #  enable = true;
  #  wrapperFeatures.gtk = true;
  #};
  # TODO: move xwayland to home-manager
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-hyprland];
  };
  services.dbus.enable = true;
  #opengl
  hardware.opengl = {
   enable = true;
   driSupport = true;
   driSupport32Bit = true;
  };



  ##ALOW INSECURE PKGS
  nixpkgs.config.permittedInsecurePackages = [
                "electron-25.9.0"
              ];

  ## ZSH
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
    #fira-code
    #fira-code-symbols
  ];

  system.stateVersion = "24.05"; # Did you read the comment?
  
  # HOME MANAGER
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
