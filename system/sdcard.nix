{ nixpkgs, packages }:

(import "${toString nixpkgs}/nixos/lib/eval-config.nix" {
  system = "aarch64-linux";
  modules = [
    ./sdimage.nix
    "${toString nixpkgs}/nixos/modules/profiles/base.nix"
    ../modules/default.nix

    ({ pkgs, lib, config, ... }: {
      boot.loader.grub.enable = false;
      boot.loader.generic-extlinux-compatible.enable = true;
      # fastrhino.bootloader.enable = true;
      hardware.deviceTree.name = "rockchip/rk3568-r66s.dtb";
      hardware.deviceTree.enable = true;
      boot.kernelPackages = pkgs.linuxPackages_latest;
      boot.supportedFilesystems = lib.mkForce [ "btrfs" "reiserfs" "vfat" "f2fs" "xfs" "ntfs" "cifs" ];
      boot.consoleLogLevel = lib.mkDefault 7;
      boot.kernelParams = ["console=ttyS2,1500000" "console=tty1"];

      sdImage = {
        firmwareSize = 512;
        firmwarePartitionOffset = 32;

        populateFirmwareCommands = ''
          ${config.boot.loader.generic-extlinux-compatible.populateCmd} -c ${config.system.build.toplevel} -d ./firmware
        '';

        postBuildCommands = let
          uboot = packages.fastrhino-uboot;
        in ''
          ${pkgs.parted}/bin/parted $img set 1 boot on
          dd if=${uboot}/idbloader.img of=$img seek=64 conv=notrunc
          dd if=${uboot}/u-boot.itb of=$img seek=16384 conv=notrunc
        '';
        populateRootCommands = "";
        compressImage = false;
      };
    })
  ];
}).config.system.build.sdImage
