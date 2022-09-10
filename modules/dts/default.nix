{ pkgs, ... }:

{
  hardware.deviceTree.kernelPackage = pkgs.runCommand "fake-kernel-with-just-dtb" {} ''
    mkdir -p $out/dtbs/rockchip
    cp ${./rockchip.dtb} $out/dtbs/rockchip/rk3568-r66s.dtb
  '';
}
