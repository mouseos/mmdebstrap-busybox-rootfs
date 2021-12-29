#!/bin/bash

#clean
echo Cleaning rootfs
sudo rm -r ./rootfs/*
#mmdebootstrapでbusybox ベースのrootfs作成
mmdebstrap --variant=custom \
 --dpkgopt='path-exclude=/usr/share/man/*' \
 --dpkgopt='path-exclude=/usr/share/locale/*' \
 --dpkgopt='path-exclude=/usr/share/doc/*' \
 --dpkgopt='path-exclude=/var/lib/apt/lists/*debian*' \
 --dpkgopt='path-exclude=/var/cache/apt/*.bin' \
--include=busybox,base-files \
 focal ./rootfs http://jp.archive.ubuntu.com/ubuntu/
#シンボリックリンク作成
sudo chroot ./rootfs /bin/busybox --install -s /bin
#ホスト名
sudo chroot ./rootfs /bin/sh -c "echo "busybox-debian" > /etc/hostname"

sudo cp etc/group rootfs/etc
sudo cp etc/passwd rootfs/etc
sudo cp etc/shadow rootfs/etc
sudo chmod 640 rootfs/etc/shadow
#passwdパッケージを使う場合のみ
#sudo cp -r -v etc/pam.d/ rootfs/etc

