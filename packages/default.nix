{ nixpkgs }:

with nixpkgs;

rec {
  fastrhino-uboot = callPackage ./uboot { };
}
