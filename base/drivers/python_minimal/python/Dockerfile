FROM cityofcapetown/datascience_python_minimal:latest

LABEL authors="Riaz Arbi,Gordon Inggs"

# Additional Python dependencies
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update && \
    apt-get install -y \
    libfreetype6-dev \
    pkg-config \
    libpng-dev \
    texlive-xetex \
    texlive-fonts-recommended \
    texlive-generic-recommended \
    pandoc \
    libspatialindex-dev \
    nmap \
    gfortran \
    libproj-dev \
    proj-data proj-bin \
    unzip \
    libgeos-dev

COPY python_additions.sh .

RUN bash python_additions.sh

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
