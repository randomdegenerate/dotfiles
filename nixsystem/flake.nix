{
  description = "Sandil's configuration flake";

  inputs = {
    #nixpkgs repo
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    #osu stable stuff
    nix-gaming.url = "github:fufexan/nix-gaming";

    # noctalia stuff
    noctalia = {
        url = "github:noctalia-dev/noctalia/cachix";
    };

    noctalia-greeter = {
        url = "github:noctalia-dev/noctalia-greeter";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    # hyprland plugins
    hy3 = {
      url = "github:outfoxxed/hy3";
      # or "github:outfoxxed/hy3" to follow the development branch.
      # (you may encounter issues if you dont do the same for hyprland)
      inputs.hyprland.follows = "hyprland";
    };

    hyprmod = {
        url = "github:BlueManCZ/hyprmod";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, nixpkgs, ...}@inputs :
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
            ];
        };
    };

  };
}
