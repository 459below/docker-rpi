FROM debian:stretch

RUN apt update \
  && apt install -y \
  bc \
  binfmt-support \
  bison \
  bmap-tools \
  build-essential \
  cpio \
  cpp \
  dbus \
  debian-archive-keyring \
  debootstrap \
  dosfstools \
  flex \
  g++ \
  git-core \
  kmod \
  libelf-dev \
  libssl-dev \
  psmisc \
  qemu-user-static \
  rsync \
  sudo \
  unzip \
  whois
  
RUN git clone --depth 1 https://github.com/raspberrypi/tools.git /root/tools

ADD build-kernel.sh /root/ 
ADD build-kernel-rpi1.sh /root/
ADD build-module.sh /root/
