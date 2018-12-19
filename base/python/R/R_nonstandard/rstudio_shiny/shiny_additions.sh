#!/usr/bin/env bash

apt-get install -y \
    pandoc \
    pandoc-citeproc && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

wget -q "https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-1.5.7.907-amd64.deb" -O ss-latest.deb && \
  gdebi -n ss-latest.deb && \
  rm -f ss-latest.deb && \
  R -e "install.packages(c('shiny', 'rmarkdown'), repos='https://cran.rstudio.com/')" && \
  cp -R /usr/local/lib/R/site-library/shiny/examples/* /srv/shiny-server/ && \
  rm -rf /var/lib/apt/lists/*