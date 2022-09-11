{ ... }:

{
  imports = [
    ./bootloader
    ./dts
  ];


  boot.kernelPatches = [
    {
      name = "add-r66s-dts";
      patch = ./0001-feat-add-rockchip-dtsi.patch;
    }
  ];
}
