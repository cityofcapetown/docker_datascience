FROM ubuntu:18.04

LABEL authors="Riaz Arbi,Gordon Inggs"

# Utility packages
RUN DEBIAN_FRONTEND=noninteractive \
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
  sudo \
  locales \
  dnsutils \
  curl \
  screen

# Setting the timezone
ENV TZ="Africa/Johannesburg"
RUN echo $TZ > /etc/timezone && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata && \
  rm /etc/localtime && \
  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
  dpkg-reconfigure -f noninteractive tzdata && \
  apt-get clean

# Define en_ZA
RUN DEBIAN_FRONTEND=noninteractive \
  locale-gen en_ZA && \
  locale-gen en_ZA.UTF-8 && \
  dpkg-reconfigure --frontend=noninteractive locales && \
  update-locale

ENV LANGUAGE en_ZA.UTF-8
ENV LANG en_ZA.UTF-8
ENV LC_ALL en_ZA.UTF-8
ENV LC_CTYPE en_ZA.UTF-8
ENV LC_MESSAGES en_ZA.UTF-8

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
