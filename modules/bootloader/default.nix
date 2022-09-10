{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.fastrhino.bootloader;

  ubootBootloaderBuilder = pkgs.substituteAll {
    src = ./bootloader.sh;
    isExecutable = true;
    inherit (pkgs) bash;
    path = with pkgs; [ coreutils ubootTools ];
  };
in
{
  options = {
    fastrhino.bootloader = {
      enable = mkOption {
        default = false;
        type = types.bool;
      };

      populateCmd = mkOption {
        default = "";
        type = types.str;
      };
    };
  };

  config = mkIf cfg.enable {
    system.build.installBootLoader = ubootBootloaderBuilder;
    system.build.loader.id = "fastrhino-bootloader";
    system.boot.loader.kernelFile = pkgs.stdenv.hostPlatform.linux-kernel.target;
  };
}
