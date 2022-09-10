{
  description = "FastRhino R66S (RK3568) with NixOS inside";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem [ "aarch64-linux" "x86_64-linux" ] (system: let
      pkgs = import nixpkgs {
        system = system;
      };
      packages = import ./packages { nixpkgs = pkgs; };
      in
      {
        legacyPackages = packages;
        sdImage = import ./system/sdcard.nix { inherit nixpkgs packages; };
      }
    );
}
