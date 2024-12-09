{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
  in {
    homeConfigurations = {
      andre = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          ./home-manager/home-ubuntu.nix
          {nixpkgs.overlays = import ./overlays {inherit inputs;};}
        ];
      };
      "andre@rpi4" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."aarch64-linux";
        modules = [
          ./home-manager/rpi4/home.nix
          {nixpkgs.overlays = import ./overlays {inherit inputs;};}
        ];
      };
      "andre@nixos" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          ./home-manager/home.nix
          {nixpkgs.overlays = import ./overlays {inherit inputs;};}
        ];
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
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/rpi4/configuration.nix
          {nixpkgs.overlays = import ./overlays {inherit inputs;};}

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.andre = import ./home-manager/rpi4/home.nix;
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
