FROM cityofcapetown/datascience:R_nonstandard

LABEL authors="Riaz Arbi,Gordon Inggs"

# Install and setup Pandoc
RUN apt-get update && \
    apt-get install -y \
    pandoc \
    pandoc-citeproc && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Miktex
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D6BC243565B2087BC3F897C9277A7293F59E4889 && \
    echo "deb http://miktex.org/download/ubuntu bionic universe" | tee /etc/apt/sources.list.d/miktex.list && \
    apt-get update && \
    apt-get install -y \
    miktex && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install and setup Rstudio Server
RUN apt-get update && \
    apt-get install gdebi-core dpkg -y && \
    wget -q https://download2.rstudio.org/rstudio-server-1.1.463-amd64.deb -O rs-latest.deb && \
    gdebi -n rs-latest.deb && \
    rm -f rs-latest.deb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install and setup Shiny Server
RUN wget -q "https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-1.5.9.923-amd64.deb" -O ss-latest.deb && \
  gdebi -n ss-latest.deb && \
  rm -f ss-latest.deb && \
  R -e "install.packages(c('shiny', 'rmarkdown'), repos='https://cran.rstudio.com/')" && \
  cp -R /usr/local/lib/R/site-library/shiny/examples/* /srv/shiny-server/ && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
# Copy in the Shiny Server conf file
COPY shiny-server.conf /etc/shiny-server/shiny-server.conf

# Copy in the run scripts
COPY run_rstudio.sh /run_scripts/
RUN chmod +x /run_scripts/run_rstudio.sh
COPY run_shiny.sh /run_scripts/
RUN chmod +x /run_scripts/run_shiny.sh

# Copy in the NGINX confs
COPY rstudio.conf /etc/nginx/paths-available/
COPY shiny.conf /etc/nginx/paths-available/




