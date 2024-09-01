{
  description = "nix config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager,  ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
  
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
       };
    };
}

