#!/usr/bin/env bash

# Utility packages
DEBIAN_FRONTEND=noninteractive \
  apt-get clean && \
  apt-get update && \
  apt-get install -y \
  vim \
  nano \
  htop \
  bash \
  cmake \
  make \
  gcc \
  wget \
  apt-utils \
  git \
  tzdata

# Setting the timezone
ln -fs /usr/share/zoneinfo/Africa/Johannesburg /etc/localtime
DEBIAN_FRONTEND=noninteractive dpkg-reconfigure tzdata

