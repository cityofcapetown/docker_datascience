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
  git

# Setting the timezone
TZ="Africa/Johannesburg"
echo $TZ > /etc/timezone && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata && \
  rm /etc/localtime && \
  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
  dpkg-reconfigure -f noninteractive tzdata && \
  apt-get clean

