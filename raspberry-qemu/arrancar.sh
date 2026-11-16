#!/usr/bin/env bash
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"

base="$HOME/qemu-raspberry"
qemu=/usr/bin/qemu-system-aarch64

if [[ ! -e tp4-raspios.qcow2 ]]; then
    qemu-img create -f qcow2 -F raw -b "$base/raspios.img" tp4-raspios.qcow2
fi

exec "$qemu" -machine raspi3b \
    -kernel "$base/kernel8-qemu.img" \
    -dtb "$base/bcm2710-rpi-3-b.dtb" \
    -drive file=tp4-raspios.qcow2,if=sd,format=qcow2 \
    -netdev user,id=net0,hostfwd=tcp:127.0.0.1:2222-:22 \
    -device usb-net,netdev=net0 \
    -display none -serial mon:stdio -no-reboot \
    -append "console=ttyAMA1,115200 root=/dev/mmcblk0p2 rootfstype=ext4 rootwait ro fsck.repair=yes initcall_blacklist=bcm2835_wdt_driver_init $*"
