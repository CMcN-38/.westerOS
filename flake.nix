{
  description = "Nix Flake for WesterOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Pinned nixpkgs for Transmission 4.0.0
    nixpkgs_tx.url = "github:NixOS/nixpkgs/a3d5c390fff47acf3f458903c2652f720a8e4316";

    stylix.url = "github:nix-community/stylix";

    nix-index-database = {
        url = "github:nix-community/nix-index-database";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nix-index-database, ... } @ inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations.targaryen = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/targaryen/configuration.nix
          home-manager.nixosModules.default
          nix-index-database.nixosModules.default
        ];
      };

      nixosConfigurations.stark = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/stark/configuration.nix
          home-manager.nixosModules.default
          nix-index-database.nixosModules.default
        ];
      };

      nixosConfigurations.baratheon = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/baratheon/configuration.nix
          home-manager.nixosModules.default
          nix-index-database.nixosModules.default
        ];
      };

      nixosConfigurations.lannister = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/lannister/configuration.nix
          home-manager.nixosModules.default
          nix-index-database.nixosModules.default
        ];
      };
    };
}

