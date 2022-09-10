#! @bash@/bin/sh -e

shopt -s nullglob

export PATH=/empty
for i in @path@; do PATH=$PATH:$i/bin; done

BASE_CONFIG=$1
BASE_BOOT="/boot";

while getopts "d:c:" arg; do
  case $arg in
    d) BASE_BOOT=$OPTARG;;
    c) BASE_CONFIG=$OPTARG;;
  esac
done

echo "Base Boot: "$BASE_BOOT
echo "Base Config: "$BASE_CONFIG
KERNEL_PARAMS=$(cat $BASE_CONFIG/kernel-params)

cat > $BASE_BOOT"/boot.ini" <<EOF
part uuid mmc \${devnum}:2 uuid

if test $stdout = 'serial@ff1a0000' ;
then serial_addr=',0xff1a0000';
elif test $stdout = 'serial@ff130000' ;
then serial_addr=',0xff130000';
else serial_addr=',0xfe660000';
fi;

setenv bootargs "systemConfig=$BASE_CONFIG init=$BASE_CONFIG/init $KERNEL_PARAMS"
load mmc \${devnum}:1 \${fdt_addr_r} rockchip.dtb
load mmc \${devnum}:1 \${kernel_addr_r} kernel.img

booti \${kernel_addr_r} - \${fdt_addr_r}
EOF

mkimage -A arm -O linux -T script -C none -d $BASE_BOOT"/boot.ini" $BASE_BOOT"/boot.scr"
cp $BASE_CONFIG/kernel $BASE_BOOT/kernel.img
chmod 755 $BASE_BOOT/kernel.img
