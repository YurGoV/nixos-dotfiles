# congiguration-laptop.nix
{ config, pkgs, lib, ... }:

{
  imports = [
      ./hardware-configuration-thinkpad.nix
    ];

  # kernelParams
  boot.initrd.kernelModules = [ "amdgpu" ];

  ### new for thinkpad:
  boot.kernelParams = [
    # Force use of the thinkpad_acpi driver for backlight control.
    # This allows the backlight save/load systemd service to work.
    "acpi_backlight=native"
    # With BIOS version 1.12 and the IOMMU enabled, the amdgpu driver
    # either crashes or is not able to attach to the GPU depending on
    # the kernel version. I've seen no issues with the IOMMU disabled.
    #
    # BIOS version 1.13 fixes the IOMMU issues, but we leave the IOMMU
    # in software mode to avoid a sad experience for those people that drew
    # the short straw when they bought their laptop.
    "iommu=soft"
    # Explicitly set amdgpu support in place of radeon
    # ad GPS say for  integrated Radeon graphics based on the Vega architecture,
    # not RDNA2.
    "radeon.cik_support=0"
    "amdgpu.cik_support=1"
  ];

  # Set to boot on last booting OS:
  boot.loader.grub.default = "saved";  # Boot the last selected entry
  boot.loader.grub.extraEntries = ''
    GRUB_SAVEDEFAULT=true
  '';



  hardware.trackpoint.enable = lib.mkDefault true;
  hardware.trackpoint.emulateWheel = lib.mkDefault config.hardware.trackpoint.enable;

  services.fstrim.enable = lib.mkDefault true;

  hardware.amdgpu.initrd.enable = lib.mkDefault true;
  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;

  boot.extraModulePackages = [ config.boot.kernelPackages.zenpower ];
  boot.kernelModules = [ "zenpower" ];

  # boot params
  boot.loader.systemd-boot.enable = false;
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;

  ## Powermanagement
  powerManagement.enable = true;

  ## LAPTOP Configure
  services.tlp = {
      enable = true;
      settings = {
       USB_AUTOSUSPEND = 0;
       #Optional helps save long term battery health
       START_CHARGE_THRESH_BAT0 = 55; # 55 and bellow it starts to charge
       STOP_CHARGE_THRESH_BAT0 = 60; # 60 and above it stops charging
       # CPU settings for AC power (when plugged in)
       CPU_SCALING_GOVERNOR_ON_AC="powersave";# Keep CPU in 'powersave' governor when on AC to limit high-frequency usage
       CPU_BOOST_ON_AC=0; # Disable CPU boost on AC to avoid unnecessary high-performance spikes
       #CPU_ENERGY_PERF_POLICY_ON_AC="balance_performance";
       CPU_ENERGY_PERF_POLICY_ON_AC="balance_power"; # Favor power efficiency while maintaining reasonable performance
       
       # CPU settings for Battery power (when unplugged)
       CPU_SCALING_GOVERNOR_ON_BAT="powersave"; # Use 'powersave' to prioritize energy savings on battery
       CPU_BOOST_ON_BAT=0; # Disable CPU boost on battery to save energy and reduce wear
       CPU_ENERGY_PERF_POLICY_ON_BAT="power"; # Prioritize power savings over performance when on battery
       
       # CPU frequency limits to prevent excessive power usage and heat
       #CPU_MIN_PERF_ON_AC=40; # Minimum CPU performance percentage on AC power (40%)
       CPU_MAX_PERF_ON_AC=85; # Maximum CPU performance percentage on AC power (85%)
       #CPU_MIN_PERF_ON_BAT=20; # Minimum CPU performance percentage on battery (20%)
       CPU_MAX_PERF_ON_BAT=60; # Maximum CPU performance percentage on battery (60%)

       ### # CPU_SCALING_GOVERNOR_ON_AC = "performance";
       ## CPU_SCALING_GOVERNOR_ON_AC = "schedutil";
       ## # CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
       ## CPU_SCALING_GOVERNOR_ON_BAT = "schedutil"; # Use schedutil for dynamic power management

       ## CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
       ## CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

       ## CPU_MIN_PERF_ON_AC = 0;
       ## CPU_MAX_PERF_ON_AC = 60;
       ## CPU_MIN_PERF_ON_BAT = 0;
       ## CPU_MAX_PERF_ON_BAT = 50;
      };
  };


  networking.hostName = "thinkpad"; # Define your hostname.

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

  services.thermald.enable = false; # Disable thermald for non-Intel CPUs
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.enable = true;

  security.pam.services.swaylock = {};
  # experimental 2024.12.25
  # security.pam.services.gdm-password.enableGnomeKeyring = true;
  # services.gnome.gnome-keyring.enable = true;

  services.xserver.xkb.variant = "";
  services.xserver.xkb.options = "grp:rctrl_toggle";
  services.xserver.xkb.layout = "us,ua";


  # Enable CUPS to print documents.
  #services.printing.enable = true;

  # Enable sound with pipewire.
  # sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;



  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.yurgo = {
    isNormalUser = true;
    description = "yurgo";
    extraGroups = [ "networkmanager" "wheel" "docker" "video" "plugdev" ];
  };
  security.sudo.extraRules= [
  {  users = [ "yurgo" ];
    commands = [
       { command = "ALL" ;
         options= [ "NOPASSWD" ]; # "SETENV" # Adding the following could be a good idea
      }
    ];
  }
];

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
    vaapiVdpau
    libvdpau-va-gl
    libvdpau-va-gl
    libva-utils
    vulkan-tools
    vulkan-loader
    opencl-headers
    ocl-icd
    clinfo
    # rocm-opencl
    opencl-headers
    # mesa_drivers
    mesa
    # experimental 2024.12.25
    # gnome-keyring
    # experimental 2024.12.25
    # for react 19 migrate:
    # libsecret
    # glib
  ];
  ## just for test
  environment.variables = {
    #try in 24.11:
    AMD_VULKAN_ICD = "RADV";

    ROC_ENABLE_PRE_VEGA = "1";
  };

  # TODO: move xwayland to home-manager
  # wayland
  programs.hyprland = {
    # Install the packages from nixpkgs
    enable = true;
    # Whether to enable XWayland
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-hyprland];
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland];
    ## new 2024.12.35
    xdgOpenUsePortal= true;
    config = {
      # common.default = ["gtk"];
      common.default = ["hyprland"];
      hyprland.default = ["hyprland"];
    };

    # extraPortals = [
    #   pkgs.xdg-desktop-portal-gtk
    # ];
  };
  services.dbus.enable = true;

  ### GNOME keyring:
  # services.gnome.gnome-keyring.enable = true;

  ## in 24.11 need to change .opengl to .grapics: hardware.graphics
  # hardware.opengl = {
  hardware.graphics = {
   enable = true;

   ## try (enable) in 24.11:
   extraPackages = with pkgs; [
     rocmPackages.clr.icd
     pkgs.amdvlk
     pkgs.driversi686Linux.amdvlk
   ];
  };

  # new: added 12.2024:
  hardware.enableAllFirmware = true;

  ##ALOW INSECURE PKGS
  nixpkgs.config.permittedInsecurePackages = [
                "electron-25.9.0"
              ];

  ## ZSH
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];

  # Do not change this value - it means the version of FIRST installed!!!
  system.stateVersion = "24.05"; # Did you read the comment?
  
  # HOME MANAGER
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
