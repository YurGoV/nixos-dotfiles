{ config, lib, pkgs, ... }:
  {
  # Simply install just the packages
  environment.packages = with pkgs; [
    # User-facing stuff that you really really want to have
    vim # or some other editor, e.g. nano or neovim
    #procps
    ##killall
    ##diffutils
    #findutils
    #utillinux
    ##tzdata
    #hostname
    #man
    #gnugrep
    #gnupg
    #gnused
    #gnutar
    #bzip2
    #gzip
    #xz
    #zip
    #unzip
    neovim
    git
  ];                                                 
    # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".bak";

  # Read the changelog before changing this value
  system.stateVersion = "24.05";


  home-manager = {
      config = ./home-manager/home-nix-on-droid.nix;
      backupFileExtension = "hm-bak";
      useGlobalPkgs = true;
  };

  #home-manager.config = ./home.nix;

  # Set up nix for flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Set your time zone
  #time.timeZone = "Europe/Berlin";
}