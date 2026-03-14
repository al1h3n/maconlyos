# flake.nix - Supports both NixOS and macOS (nix-darwin).
{
  description = "Local (user) configuration for MolnixOS";

  inputs = {
    nixpkgs.url        = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-stable = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    # nix-darwin - macOS system configuration.
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NUR - Nix User Repository.
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, nix-darwin, nur, ... }@inputs:
  let
    variables  = import ./variables.nix;
    pkgsSource = if variables.channel == "stable" then nixpkgs-stable else nixpkgs;
    hmSource   = if variables.channel == "stable"
      then inputs.home-manager-stable
      else inputs.home-manager;

    # Shared home-manager config used by both NixOS and macOS.
    sharedHmConfig = {
      extraSpecialArgs = { inherit variables inputs; };
      useGlobalPkgs    = true;
      useUserPackages  = true;
      users.${variables.username} = import ./home/home.nix;
      backupFileExtension = "backup";
    };
  in {

    # =====================
    # NixOS configuration.
    # =====================
    nixosConfigurations.main = pkgsSource.lib.nixosSystem {
      system = variables.system;
      modules = [
        { nixpkgs.overlays = [ nur.overlays.default ]; }
        hmSource.nixosModules.home-manager
        ./configuration.nix
        { home-manager = sharedHmConfig; }
      ];
    };

    # =====================
    # macOS configuration.
    # =====================
    darwinConfigurations.main = nix-darwin.lib.darwinSystem {
      system = variables.system;
      modules = [
        { nixpkgs.overlays = [ nur.overlays.default ]; }
        hmSource.darwinModules.home-manager
        ./darwin-configuration.nix
        { home-manager = sharedHmConfig; }
      ];
    };
  };
}
