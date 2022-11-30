#!/usr/bin/env bash
set -e

# Selenium headless browser
# Firefox driver
wget https://github.com/mozilla/geckodriver/releases/download/v0.31.0/geckodriver-v0.31.0-linux64.tar.gz -O geckodriver.tar.gz && \
  tar -xzf geckodriver.tar.gz && \
  rm -rf geckodriver.tar.xz && \
  mv geckodriver /usr/bin/geckodriver

# Headless X environment
apt-get update && \
  apt-get install -y chromium-browser \
                     xvfb \
                     firefox \
                     libdbus-glib-1-2 \
                     libgtk2.0-0 \
                     libasound2
