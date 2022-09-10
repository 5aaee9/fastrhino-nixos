{ buildUBoot, fetchpatch, fetchgit, ... }:

let
  rkbin = fetchgit {
    url = "https://github.com/rockchip-linux/rkbin.git";
    rev = "b0c100f1a260d807df450019774993c761beb79d";
    sha256 = "sha256-V7RcQj3BgB2q6Lgw5RfcPlOTZF8dbC9beZBUsTvaky0=";
  };
in
buildUBoot {
  defconfig = "r66s-rk3568_defconfig";
  extraMeta.platforms = [ "aarch64-linux" ];
  filesToInstall = [ "idbloader.img" "u-boot.itb" ];
  postConfigure = ''
    cp ${rkbin}/bin/rk35/rk3568_ddr_1560MHz_v1.13.bin ram_init.bin
  '';
  extraPatches = [
    (fetchpatch {
      url = "https://github.com/coolsnowwolf/lede/raw/master/package/boot/uboot-rockchip/patches/001-rockchip-rk3568-add-boot-device-detection.patch";
      sha256 = "0v6d5q3d4fln6byg6dw7fvd87zvgwybv2fgpzbhbfsfivsfbw1a7";
    })
    (fetchpatch {
      url = "https://github.com/coolsnowwolf/lede/raw/master/package/boot/uboot-rockchip/patches/002-rockchip-rk3568-enable-automatic-power-savings.patch";
      sha256 = "0bl8w1yqj35mk3zx5w47sgx3kd1r7imlzlwifpxzm3wy7vyw9kl6";
    })
    (fetchpatch {
      url = "https://github.com/coolsnowwolf/lede/raw/master/package/boot/uboot-rockchip/patches/003-Makefile-rockchip-HACK-build-rk3568-images.patch";
      sha256 = "0sdws4cjymmigvipzrk9z31jwk501mx0xcigkh8mq91gh21bz3f1";
    })
    (fetchpatch {
      url = "https://github.com/coolsnowwolf/lede/raw/master/package/boot/uboot-rockchip/patches/004-arm-dts-sync-rk3568-with-linux.patch";
      sha256 = "1sk5zv7rab9zpdhy43mmn2wz1fjh8fgv3z9w0xb4k6p352nhbpja";
    })
    (fetchpatch {
      url = "https://github.com/coolsnowwolf/lede/raw/master/package/boot/uboot-rockchip/patches/005-rockchip-rk356x-HACK-fix-sdmmc-support.patch";
      sha256 = "0vhxnnv7zw76wj5ffazidipgylwnl0f36bnmgd1949fkai9zsbzk";
    })
    (fetchpatch {
      url = "https://github.com/coolsnowwolf/lede/raw/master/package/boot/uboot-rockchip/patches/006-rockchip-rk356x-add-quartz64-a-board.patch";
      sha256 = "1h0ahdpikaw0gi0bplp0agz1m4p4pl7fan88r9xxq4iv79bvg5ds";
    })
    (fetchpatch {
      url = "https://github.com/coolsnowwolf/lede/raw/master/package/boot/uboot-rockchip/patches/007-gpio-rockchip-rk_gpio-support-v2-gpio-controller.patch";
      sha256 = "1ksj0swdqs1g0m8038gi0vpkc9xdpcr0kv97wqzkah7sbq85hf4b";
    })
    (fetchpatch {
      url = "https://github.com/coolsnowwolf/lede/raw/master/package/boot/uboot-rockchip/patches/008-rockchip-allow-sdmmc-at-full-speed.patch";
      sha256 = "1h7kc2jpa7xpnd18xxwg7ywg193yg0ll4gm85grc214pcfrr2194";
    })
    (fetchpatch {
      url = "https://github.com/coolsnowwolf/lede/raw/master/package/boot/uboot-rockchip/patches/009-rockchip-defconfig-add-gpio-v2-to-quartz64.patch";
      sha256 = "1lzpsssxsk0lpnq7xry7bwabvdb8dspkra9pdpq4aqzrsw80ija7";
    })
    (fetchpatch {
      url = "https://github.com/coolsnowwolf/lede/raw/master/package/boot/uboot-rockchip/patches/010-rockchip-rk356x-enable-usb2-support-on-quartz64-a.patch";
      sha256 = "1i93v2rjnnqap858l5wqv4s5iwby6sbpbfhvdmpj60ymv8g3fp01";
    })
    (fetchpatch {
      url = "https://github.com/coolsnowwolf/lede/raw/master/package/boot/uboot-rockchip/patches/011-rockchip-rk356x-attempt-to-fix-ram-detection.patch";
      sha256 = "1a7kzvmws7kq0dvvjffzbvfix4mcc0bwdzxvcdrhyhjyj6dl3xl4";
    })
    (fetchpatch {
      url = "https://github.com/coolsnowwolf/lede/raw/master/package/boot/uboot-rockchip/patches/012-resync-rk3566-device-tree-with-mainline.patch";
      sha256 = "1cfb8wnlvnj0lzh4kng9sndvxhcqwr48q0b58bpf67c7kc8yg6v6";
    })
    (fetchpatch {
      url = "https://github.com/coolsnowwolf/lede/raw/master/package/boot/uboot-rockchip/patches/013-rockchip-rk356x-add-bpi-r2-pro-board.patch";
      sha256 = "0i2k3cndqrcn5xfw9rcisbxbdnsjfgxai5wz7zpyhygxrpm1vr0g";
    })
    (fetchpatch {
      url = "https://github.com/coolsnowwolf/lede/raw/master/package/boot/uboot-rockchip/patches/014-uboot-add-Radxa-ROCK-3A-board.patch";
      sha256 = "0gndz5vspz7va8052fwrpmjs684sw7xqbghxkx0phbkmwim01gr0";
    })
    (fetchpatch {
      url = "https://github.com/coolsnowwolf/lede/raw/master/package/boot/uboot-rockchip/patches/015-uboot-add-NanoPi-R5S-board.patch";
      sha256 = "1vgk9vsc5ycdlqqfhrlbrmcfhk7z0cyq0x6rzi8b0qg2q59czjn4";
    })
    (fetchpatch {
      url = "https://github.com/coolsnowwolf/lede/raw/master/package/boot/uboot-rockchip/patches/100-Convert-CONFIG_USB_OHCI_NEW-et-al-to-Kconfig.patch";
      sha256 = "0hqzj10vh9vmgjfx6l589j9v8wk5npm22x0yra9v2vl4csv4mfh8";
    })
    (fetchpatch {
      url = "https://github.com/coolsnowwolf/lede/raw/master/package/boot/uboot-rockchip/patches/104-mkimage-add-public-key-for-image.patch";
      sha256 = "1rkbmpv85wd43hx74kkmnf4srgy50xzyz62jmhj2nls8jv41qsd1";
    })
    (fetchpatch {
      url = "https://github.com/coolsnowwolf/lede/raw/master/package/boot/uboot-rockchip/patches/105-Only-build-dtc-if-needed.patch";
      sha256 = "0sqf61irj8bfs6z86a0yq3qx9xj1kzbwr7sn2x11s54accay9wfa";
    })
    (fetchpatch {
      url = "https://github.com/coolsnowwolf/lede/raw/master/package/boot/uboot-rockchip/patches/106-no-kwbimage.patch";
      sha256 = "13gx799c6mbb817yfsh3nw50ls4s3vk319v5ak46v7q8biz5pbks";
    })
    ./313-rockchip-rk3568-Add-support-for-fastrhino-r66s.patch
  ];
}
