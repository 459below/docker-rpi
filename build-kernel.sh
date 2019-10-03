#!/bin/bash
set -e
VERSION=$1
cd /root/building

if [ ! -d linux-rpi-$VERSION ] ; then
        wget https://github.com/raspberrypi/linux/archive/rpi-$VERSION.zip
        unzip rpi-$VERSION.zip
fi

export PATH=$PATH:/root/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin
export ARCH=arm
export CROSS_COMPILE=arm-linux-gnueabihf-
export KERNEL=kernel7
cd linux-rpi-$VERSION
make mrproper
make bcm2709_defconfig
sed -i \
-e "s/\(^CONFIG_VIDEO_.*\=\).*/\1n/" \
-e "s/\(^CONFIG_MEDIA_TUNER.*\=\).*/\1n/" \
-e "s/\(^CONFIG_DVB.*\=\)[ym]/\1n/" \
-e "s/\(^CONFIG_REISERFS.*\=\).*/\1n/" \
-e "s/\(^CONFIG_JFS.*\=\).*/\1n/" \
-e "s/\(^CONFIG_XFS.*\=\).*/\1n/" \
-e "s/\(^CONFIG_GFS2.*\=\).*/\1n/" \
-e "s/\(^CONFIG_OCFS2.*\=\).*/\1n/" \
-e "s/\(^CONFIG_HFS.*\=\).*/\1n/" \
-e "s/\(^CONFIG_JFFS2.*\=\)[ym]/\1n/" \
-e "s/\(^CONFIG_UBIFS.*\=\).*/\1n/" \
-e "s/\(^CONFIG_SQUASHFS.*\=\)[ym]/\1n/" \
-e "s/\(^CONFIG_W1.*\=\)[ym]/\1n/" \
-e "s/\(^CONFIG_HAMRADIO.*\=\).*/\1n/" \
-e "s/\(^CONFIG_CAN.*\=\).*/\1n/" \
-e "s/\(^CONFIG_IRDA.*\=\).*/\1n/" \
-e "s/\(^CONFIG_WIMAX.*\=\)[ym]/\1n/" \
-e "s/\(^CONFIG_6LOWPAN.*\=\).*/\1n/" \
-e "s/\(^CONFIG_IEEE802154.*\=\).*/\1n/" \
-e "s/\(^CONFIG_NFC.*\=\).*/\1n/" \
-e "s/\(^CONFIG_FB_TFT=.*\=\).*/\1n/" \
-e "s/\(^CONFIG_TOUCHSCREEN.*\=\).*/\1n/" \
-e "s/\(^CONFIG_USB_GSPCA_.*\=\).*/\1n/" \
-e "s/\(^CONFIG_DRM.*\=\).*/\1n/" \
-e "s/\(^CONFIG_CRYPTO_AES_ARM.*\=\).*/\1n/" \
-e "s/\(^CONFIG_CRYPTO_SHA1_ARM_NEON.*\=\).*/\1n/" \
-e "s/\(^CONFIG_W1.*\=\).*/\1y/" \
-e "s/\(^CONFIG_W1_CON.*\=\).*/\1y/" \
-e "s/\(^CONFIG_BTRFS.*\=\).*/\1y/" \
-e "s/\(^CONFIG_USB_LED_TRIG.*\=\).*/\1y/" \
-e "s/\(^CONFIG_USB_GSPCA_OV534.*\=\).*/\1y/" \
".config"
make -j8 Image
make -j8 modules
make -j8 scripts
make -j8 dtbs
make -j8 deb-pkg
