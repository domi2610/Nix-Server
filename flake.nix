{
  description = "Home Manager configuration of ubuntu";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system1 = "aarch64-linux";
	system2 = "x86_64-linux";
      pkgs1 = nixpkgs.legacyPackages.${system1};
	pkgs2 = nixpkgs.legacyPackages.${system2};
    in {
      homeConfigurations."ubuntu" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs1;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home-ubuntu.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
	homeConfigurations."wsl" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs2;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home-domenic.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
