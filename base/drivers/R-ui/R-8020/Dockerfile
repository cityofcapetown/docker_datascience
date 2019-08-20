FROM cityofcapetown/datascience:R-ui

LABEL authors="Riaz Arbi,Gordon Inggs"

USER root

# R PACKAGES ============================================================

ARG r_packages="\
    tidyverse \
    arrow \
    reticulate \
    skimr \
    sf \
    "

RUN install2.r --error -n 3 -s --deps TRUE $r_packages \
# Sorting out manual install instructions on an ad-hoc basis
 && Rscript -e "arrow::install_arrow()"

# NOT IN CRAN

# h3-r for uber h3 hex traversal
RUN git clone --single-branch --branch "feature/hex-ring" https://github.com/crazycapivara/h3-r.git \
    && cd h3-r \
    && chmod +x install-h3c.sh \
    && bash ./install-h3c.sh \
    && R -q -e 'devtools::install()' \
    && cd .. \
    && rm -rf h3-r

# TEX AND MICROSOFT FONTS ================================================

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


USER $NB_USER
ENV PATH="${PATH}:/usr/lib/rstudio-server/bin"
