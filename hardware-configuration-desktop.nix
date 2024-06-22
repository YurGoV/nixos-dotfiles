# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "ohci_pci" "ehci_pci" "pata_amd" "ahci" "usb_storage" "usbhid" "floppy" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  ## test for sleep
  # boot.resumeDevice  = "/var/lib/swapfile";

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/8a16601a-f6d0-4968-9133-39bae37c4349";
      fsType = "ext4";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/ab0ee4eb-2cfd-4c80-8f30-88cb5577ed02";
      fsType = "ext4";
    };

  # swapDevices = [ ];
  swapDevices =
    [ { device = "/dev/disk/by-uuid/30f06202-3d66-41ef-adb0-6f0dae3f4958"; }
      ## test for sleep
      # { device = "/var/lib/swapfile"; size = 27*1024; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s10.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
