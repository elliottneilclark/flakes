{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, rust-overlay, ... }:
    let
      user = "elliott";
      location = "$HOME/.setup";
    in {
      nixosConfigurations = (import ./modules/hosts {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs home-manager rust-overlay user location;
      });
    };
}

