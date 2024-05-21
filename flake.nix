{
  description = "nix config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
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

