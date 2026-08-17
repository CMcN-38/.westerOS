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
    
    # Walker app selector setup
    elephant.url = "github:abenz1267/elephant";

    walker = {
        url = "github:abenz1267/walker";
        inputs.elephant.follows = "elephant";
    };
  };

  outputs = { self, nixpkgs, home-manager, nix-index-database, walker, ... } @ inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      # secrets.nix is gitignored — requires --impure to read from disk at build time.
      # See secrets.example.nix for the expected format.
      secretsPath = /home/cameron/.westerOS/secrets.nix;
      secrets = if builtins.pathExists secretsPath then import secretsPath else {};
    in
    {
      nixosConfigurations.targaryen = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs secrets; };
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
        specialArgs = { inherit inputs secrets; };
        modules = [
          ./hosts/baratheon/configuration.nix
          home-manager.nixosModules.default
          nix-index-database.nixosModules.default
        ];
      };

      nixosConfigurations.lannister = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs secrets; };
        modules = [
          ./hosts/lannister/configuration.nix
          home-manager.nixosModules.default
          nix-index-database.nixosModules.default
        ];
      };
    };
}

