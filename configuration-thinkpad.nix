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
  hardware.trackpoint.enable = lib.mkDefault true;
  hardware.trackpoint.emulateWheel = lib.mkDefault config.hardware.trackpoint.enable;

  services.fstrim.enable = lib.mkDefault true;

  hardware.amdgpu.initrd.enable = lib.mkDefault true;
  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;

  boot.extraModulePackages = [ config.boot.kernelPackages.zenpower ];
  boot.kernelModules = [ "zenpower" ];

  # boot.kernelModules = [
  #   "acpi_call"
  #   # Add other kernel modules if needed
  # ] ++ (config.boot.kernelModules or []);
  #
  # Conditional kernel module loading based on TLP
  # boot.kernelModules = lib.mkIf config.services.tlp.enable [
  #   "acpi_call"
  #   # Add other kernel modules if needed
  # ] ++ (config.boot.kernelModules or []);
  ### new for thinkpad:


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
  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  #? Intel drivers
  # services.xserver.videoDrivers = [ "amdgpu-pro" ];
  # services.xserver.videoDrivers = [ "amdgpu" ];
  

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
  # hardware.bluetooth.enable = true; # enables support for Bluetooth
  # hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  # services.blueman.enable = true;
  # hardware.bluetooth.settings = {
  #  General = {
  #  	  Experimental = true;
  #    };
  # };
  # hardware.enableAllFirmware = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    ###settings = {
    ###  General = {
    ###    Name = "Laptop";
    ###    ControllerMode = "dual";
    ###    FastConnectable = "true";
    ###    Experimental = "true";
    ###    Enable = "Source,Sink,Media,Socket";
    ###  };
    ###  Policy = {
    ###    AutoEnable = "true";
    ###  };
    ###};
  };
  services.blueman.enable = true;



  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.yurgo = {
    isNormalUser = true;
    description = "yurgo";
    extraGroups = [ "networkmanager" "wheel" "docker" "video" "plugdev" ];
    # packages = with pkgs; [
    # ];
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
    # xfce.xfce4-pulseaudio-plugin
    # xfce.xfce4-systemload-plugin
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
    #
    rocm-opencl-runtime
    # rocm-device-libs
    # rocm-comgr
    opencl-headers
    ocl-icd
    clinfo
    # rocm-opencl
    opencl-headers
    mesa_drivers
  ];
  ## just for test
  environment.variables = {
    # VAAPI and VDPAU config for accelerated video.
    # See https://wiki.archlinux.org/index.php/Hardware_video_acceleration
    # "VDPAU_DRIVER" = "radeonsi";
    # "LIBVA_DRIVER_NAME" = "radeonsi";
   ## test for davinci
    # LIBVA_DRIVERS_PATH = "/run/opengl-driver/lib/dri";
    # LIBVA_DRIVER_NAME = "radeonsi";
    # DRI_PRIME = "1";  # Force using the discrete GPU
    # VDPAU_DRIVER = "radeonsi";
    # VA_API_VERSION = "1.21";
   ## test for davinci
    # MESA_VAAPI_DEVICE = "/dev/dri/renderD128";
    # LIBVA_MESA_DEVICE = "/dev/dri/renderD128";
    # WLR_DRM_DEVICES = "/dev/dri/card1";  # Ensure card1 is the discrete AMD GPU
    ##
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
  # hardware.amdgpu.opencl = true;
  # hardware.amdgpu.loadInInitrd = true;
  # hardware.amdgpu = {
  #   opencl.enable = true;
  #   # loadInInitrd = true;
  # };
  hardware.opengl = {
   enable = true;
   driSupport = true;
   driSupport32Bit = true;
   ## test for davinci
   ####extraPackages = with pkgs; [
   ####   rocmPackages_5.clr.icd
   ####   rocmPackages_5.clr
   ####   rocmPackages_5.rocminfo
   ####   rocmPackages_5.rocm-runtime
   ####   # rocmPackages.clr.icd
   ####   # rocmPackages.clr
   ####   # rocmPackages.rocminfo
   ####   # rocmPackages.rocm-runtime
   ####  #
   #### #  libvdpau-va-gl
   #### #  libva-utils
   #### #  vaapiVdpau
   #### #  libva
   #### #  libva-utils
   #### #  # libva-mesa-driver
   #### #   mesa_drivers
   #### #  #
   #### # linuxKernel.packages.linux_6_6.amdgpu-pro
   #### #  rocmPackages.rocminfo
   #### #  rocmPackages.clr.icd
   #### #  rocmPackages.clr
   #### #  rocmPackages.rocm-runtime
   #### #  rocmPackages.rocm-device-libs
   #### # rocmPackages.hipblas
   #### # rocmPackages.rocminfo
   ####  # rocm-opencl-runtime
   ####  # rocm-hip
   ####  # linuxPackages_6_6.amdgpu-pro
   ####   ##rocmPackages_5.clr.icd
   ####   ##rocmPackages_5.clr
   ####   ##rocmPackages_5.rocminfo
   ####   ##rocmPackages_5.rocm-runtime
   ####];
  };
  ###systemd.tmpfiles.rules = [
  ###  "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages_5.clr}"
  ###];
  # systemd.tmpfiles.rules = [
  #   "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  # ];

   ## test for davinci

  ## just test
  # hardware.opengl.extraPackages32 = with pkgs; [
  #   driversi686Linux.amdvlk
  # ];



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
