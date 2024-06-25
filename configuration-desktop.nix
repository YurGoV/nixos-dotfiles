#enable Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration-desktop.nix
      # /etc/nixos/hardware-configuration.nix
    ];

  # kernelParams
  boot.initrd.kernelModules = [ "amdgpu" ];

  # BootParams
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "/dev/sda" ];
  boot.loader.grub.useOSProber = true;

  #for hibernate:
  # boot.kernelParams = [
  #   "resume=/dev/disk/by-uuid/30f06202-3d66-41ef-adb0-6f0dae3f4958"
  # ];
  # Enable power management
  # services.powerd.enable = true;
  # services.upower.enable = true;

  ## test for sleep
  ##boot.resumeDevice = "/var/lib/swapfile";
  ## Powermanagement (for suspend & hibernate)
  powerManagement.enable = true;


  networking.hostName = "desktop"; # Define your hostname.

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
  # ????
  # services.xserver.displayManager.lightdm.enable = false;
  # services.xserver.desktopManager.xfce.enable = true;

  # sddm for wyland experimental support
  ##services.xserver.displayManager.sddm.enable = true;
  ##services.xserver.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.enable = true;
  # services.displayManager.sddm.theme = "maya";

  security.pam.services.swaylock = {};
  # ??? gmome keyring (not work)
  # services.gnome.gnome-keyring.enable = true; #???
  # security.pam.services.sddm.enableGnomeKeyring = true;
  # ??? gmome keyring (not work)

  ## CHECK HIBERNARTE
  ## test for sleep
  # security.protectKernelImage = false;

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
  # FOR HYPRLAND
  polkit
  dconf
  xwayland
  # swaylock
  # swayidle
  wdisplays
  docker-compose
  docker
  # video hw acceleration ???
  #?? not work?? not in laptop config
  libva
  libvdpau-va-gl
  vaapiVdpau
  libvdpau-va-gl
  libva-utils
  ffmpeg_5-full
  #?? not work??
  # keyring (with other settings)
  # gnome.gnome-keyring
  ];

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
  xdg.portal = {
    enable = true;
    wlr.enable = true;
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
