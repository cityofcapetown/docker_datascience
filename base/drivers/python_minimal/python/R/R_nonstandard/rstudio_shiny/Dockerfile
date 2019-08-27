FROM cityofcapetown/datascience:R_nonstandard

LABEL authors="Riaz Arbi,Gordon Inggs"

# Install and setup Rstudio Server
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y upgrade \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y libclang-dev gdebi-core dpkg psmisc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN wget "https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.2.1335-amd64.deb" -O rs-latest.deb
RUN gdebi -n rs-latest.deb \
    && rm -f rs-latest.deb \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

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
# Copy in a sample app to /srv/shiny-server
RUN cp -R /opt/shiny-server/samples/sample-apps/hello /srv/shiny-server
RUN chmod -R 777 /srv/shiny-server

# Install and setup Tex via tinytex
ENV PATH=$PATH:/opt/TinyTeX/bin/x86_64-linux
RUN wget -qO- \
    "https://github.com/yihui/tinytex/raw/master/tools/install-unx.sh" | \
    sh -s - --admin --no-path \
    && mv ~/.TinyTeX /opt/TinyTeX \
    && /opt/TinyTeX/bin/*/tlmgr path add \
    && tlmgr install metafont mfware inconsolata tex ae parskip listings \
    && tlmgr path add \
    && Rscript -e "tinytex::r_texmf()" \
    && chown -R root:staff /opt/TinyTeX \
    && chown -R root:staff /usr/local/lib/R/site-library \
    && chmod -R g+w /opt/TinyTeX \
    && chmod -R g+wx /opt/TinyTeX/bin \
    && echo "PATH=${PATH}" >> /usr/lib/R/etc/Renviron

# Install and set up Microsoft fonts
RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | \
    debconf-set-selections \
    && DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends ttf-mscorefonts-installer

# Copy in the run scripts
COPY run_rstudio.sh /run_scripts/
RUN chmod +x /run_scripts/run_rstudio.sh
COPY run_shiny.sh /run_scripts/
RUN chmod +x /run_scripts/run_shiny.sh

# Copy in the NGINX confs
COPY rstudio.conf /etc/nginx/paths-available/
COPY shiny.conf /etc/nginx/paths-available/




