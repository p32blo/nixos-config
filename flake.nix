{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    nixos-hardware,
    ...
  } @ inputs: let
    system = "x86_64-linux";
  in {
    homeConfigurations = {
      andre = home-manager.lib.homeManagerConfiguration {
        modules = [
          ./home-manager/home.nix
          {nixpkgs.overlays = import ./overlays {inherit inputs;};}
          {targets.genericLinux.enable = true;}
        ];
        pkgs = nixpkgs.legacyPackages.${system};
      };
      "andre@rpi4" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."aarch64-linux";
        modules = [./home-manager/home.nix];
      };
    };
    nixosConfigurations = {
      nixos-desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/nixos-desktop/configuration.nix
          {nixpkgs.overlays = import ./overlays {inherit inputs;};}

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.andre = import ./home-manager/home-gui.nix;
          }
        ];
      };
      rpi4 = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./hosts/rpi4/configuration.nix
          {nixpkgs.overlays = import ./overlays {inherit inputs;};}
          nixos-hardware.nixosModules.raspberry-pi-4

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.andre = import ./home-manager/home.nix;
          }
        ];
      };
      nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/nixos/configuration.nix
          {nixpkgs.overlays = import ./overlays {inherit inputs;};}

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.andre = import ./home-manager/home.nix;
          }
        ];
      };
    };
    formatter."x86_64-linux" = nixpkgs.legacyPackages.x86_64-linux.alejandra;
    formatter."aarch64-linux" = nixpkgs.legacyPackages.aarch64-linux.alejandra;
  };
}
