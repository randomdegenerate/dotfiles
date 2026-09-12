{
  description = "Sandil's configuration flake";

  inputs = {
    #nixpkgs repo
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #catppuccin theming
    catppuccin.url = "github:catppuccin/nix";

    #osu stable stuff
    nix-gaming.url = "github:fufexan/nix-gaming";
  };

  outputs = {self, nixpkgs,catppuccin, ...}@inputs :
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
        inherit system;
        config = {
            allowUnfree = true;
        };
    };

  in
  {
    nixosConfigurations = {
        GumiTeto = nixpkgs.lib.nixosSystem {
            specialArgs = { inherit system; inherit inputs; };

            modules = [
              ./nixos/configuration.nix
              catppuccin.nixosModules.catppuccin
            ];
        };
    };

  };
}
