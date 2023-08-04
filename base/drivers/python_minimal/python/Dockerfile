FROM cityofcapetown/datascience:python_minimal

LABEL authors="Riaz Arbi,Gordon Inggs"

# Additional Python dependencies
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update && \
    apt-get install -y \
    libfreetype6-dev \
    pkg-config \
    libpng-dev \
    texlive-xetex \
    texlive-base  \
    texlive-fonts-recommended \
    texlive-latex-recommended \
    pandoc \
    libspatialindex-dev \
    nmap \
    gfortran \
    libproj-dev \
    proj-data proj-bin \
    unzip \
    libgeos-dev \
    graphviz \
    gdal-bin \
    libgdal-dev

COPY python_additions.sh .

RUN bash python_additions.sh

ENV QUARTO_VERSION 1.3.433
RUN wget "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.deb" -O \
    quarto-${QUARTO_VERSION}-linux-amd64.deb && \
    dpkg -i quarto-${QUARTO_VERSION}-linux-amd64.deb

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
