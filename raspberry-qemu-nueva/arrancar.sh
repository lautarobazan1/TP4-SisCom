#!/usr/bin/env bash
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"

exec /usr/bin/qemu-system-aarch64 \
    -machine raspi3b \
    -kernel boot/Image \
    -dtb boot/bcm2710-rpi-3-b.dtb \
    -initrd boot/initramfs8 \
    -drive file=raspios.img,if=sd,format=raw \
    -netdev user,id=net0,hostfwd=tcp:127.0.0.1:2222-:22 \
    -device usb-net,netdev=net0 \
    -display none -serial mon:stdio -no-reboot \
    -append "console=ttyAMA1,115200 root=/dev/mmcblk0p2 rootfstype=ext4 rootwait ro fsck.repair=yes quiet $*"
