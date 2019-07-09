FROM debian:stretch

RUN apt update \
  && apt install -y \
  bc \
  binfmt-support \
  bmap-tools \
  build-essential \
  cc1 \
  cpio \
  cpp \
  dbus \
  debian-archive-keyring \
  debootstrap \
  dosfstools \
  g++ \
  git-core \
  kmod \
  libelf-dev \
  libssl-dev \
  openssl-dev \
  psmisc \
  qemu-user-static \
  rsync \
  ssl \
  ssl-dev \
  sudo \
  unzip \
  whois