#!/bin/bash
export PATH=$PATH:/root/building/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin
export ARCH=arm
export CROSS_COMPILE=arm-linux-gnueabihf-
export CONFIG_RTL8192EU=m
cd rtl8192eu-linux-driver
make -C /root/building/linux KVER=4.20.0-v7 M=$(pwd)
