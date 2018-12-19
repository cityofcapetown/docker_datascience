#!/usr/bin/env bash

# Install Miktex
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D6BC243565B2087BC3F897C9277A7293F59E4889 && \
    echo "deb http://miktex.org/download/ubuntu bionic universe" | sudo tee /etc/apt/sources.list.d/miktex.list && \
    apt-get update && \
    apt-get install -y \
    miktex && \
    apt-get clean

# Install and setup Rstudio Server
apt-get install gdebi-core dpkg -y && \
    wget -q https://download2.rstudio.org/rstudio-server-1.1.456-amd64.deb -O rs-latest.deb && \
    gdebi -n rs-latest.deb && \
    rm -f rs-latest.deb