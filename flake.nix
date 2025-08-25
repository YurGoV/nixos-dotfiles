{
  description = "nix config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nix-on-droid, nixos-wsl,  ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      aarch64System = "aarch64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      aarch64Pkgs = nixpkgs.legacyPackages.${aarch64System};
  
    in {
      nixosConfigurations = {
        thinkpad = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./configuration-thinkpad.nix ];
        };
        laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./configuration-laptop.nix ];
        };
        desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./configuration-desktop.nix ];
        };
        wsl = nixpkgs.lib.nixosSystem {
          inherit system;
          # Вказуємо на наш новий системний конфіг для WSL
          modules = [  nixos-wsl.nixosModules.default
                        home-manager.nixosModules.home-manager
                       ./configuration-wsl.nix ]; 
        };
       };
       homeConfigurations = {
         thinkpad = home-manager.lib.homeManagerConfiguration {
           inherit pkgs;
  	       modules = [
	           ./home-manager/home-thinkpad.nix
	         ];
         };
         yurgo = home-manager.lib.homeManagerConfiguration {
           inherit pkgs;
  	       modules = [
	           ./home-manager/home.nix
	         ];
         };
         laptop = home-manager.lib.homeManagerConfiguration {
           inherit pkgs;
  	       modules = [
	           ./home-manager/home-laptop.nix
	         ];
         };
         wsl = home-manager.lib.homeManagerConfiguration {
           inherit pkgs;
           # Вказуємо на наш новий домашній конфіг для WSL
           modules = [ ./home-manager/home-wsl.nix ];
         };
       };
       nixOnDroidConfigurations = {
         default = nix-on-droid.lib.nixOnDroidConfiguration {
           pkgs = aarch64Pkgs;
           modules = [ ./configuration-nix-on-droid.nix ];
           extraSpecialArgs = {};
           home-manager-path = home-manager;
         };
       };
    };
}

