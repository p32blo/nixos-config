{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };

    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    nix-darwin,
    nixgl,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    system-darwin = "aarch64-darwin";
  in {
    homeConfigurations = {
      p32blo = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = {
          inherit nixgl;
        };
        modules = [
          ./home/ubuntu/home.nix
          {nixpkgs.overlays = import ./overlays {inherit inputs;};}
        ];
      };
      "andre@janine" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = {
          inherit nixgl;
        };
        modules = [
          ./home/ubuntu/home.nix
          {nixpkgs.overlays = import ./overlays {inherit inputs;};}
        ];
      };
    };
    nixosConfigurations = {
      nixos-desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./os/nixos-desktop/configuration.nix
          {nixpkgs.overlays = import ./overlays {inherit inputs;};}

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.andre = import ./home/home-gui.nix;
          }
        ];
      };
      rpi4 = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./os/rpi4/configuration.nix
          {nixpkgs.overlays = import ./overlays {inherit inputs;};}

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.andre = import ./home/rpi4/home.nix;
          }
        ];
      };
      nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./os/nixos/configuration.nix
          {nixpkgs.overlays = import ./overlays {inherit inputs;};}

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.andre = import ./home/home.nix;
          }
        ];
      };
    };
    darwinConfigurations = {
      air = nix-darwin.lib.darwinSystem {
        system = system-darwin;
        specialArgs = {inherit inputs;};
        modules = [
          ./darwin/air/configuration.nix
          {nixpkgs.overlays = import ./overlays {inherit inputs;};}

          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.andre = import ./home/air/home.nix;
          }
        ];
      };
    };
    formatter."x86_64-linux" = nixpkgs.legacyPackages.x86_64-linux.alejandra;
    formatter."aarch64-linux" = nixpkgs.legacyPackages.aarch64-linux.alejandra;
    formatter."aarch64-darwin" = nixpkgs.legacyPackages.aarch64-darwin.alejandra;
  };
}
