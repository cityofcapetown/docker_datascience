#!/usr/bin/env bash

DEBIAN_FRONTEND=noninteractive \
  apt-get clean && \
  apt-get update && \
  apt-get install -y \
  r-base \
  libxml2-dev \
  software-properties-common \
  libssh2-1-dev \
  zlib1g-dev \
  libxml2-dev \
  libssl-dev \
  libv8-3.14-dev \
  libjq-dev \
  libudunits2-dev \
  protobuf-compiler \
  libprotobuf-dev \
  libgdal-dev \
  libtool
