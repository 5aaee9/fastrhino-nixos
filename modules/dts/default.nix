{ config, pkgs, ... }:

{
  hardware.deviceTree.kernelPackage = pkgs.runCommand "fake-kernel-with-just-dtb" {} ''
    echo ${config.boot.kernelPackages.kernel}
    ls ${config.boot.kernelPackages.kernel}
    exit 1
  '';
}
