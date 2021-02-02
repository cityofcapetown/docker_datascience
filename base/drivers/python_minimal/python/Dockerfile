FROM cityofcapetown/datascience:python_minimal

LABEL authors="Riaz Arbi,Gordon Inggs"

# Additional Python dependencies
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update && \
    apt-get install -y \
    enchant libenchant-dev \
    libfreetype6-dev \
    pkg-config \
    libpng-dev \
    texlive-xetex \
    texlive-fonts-recommended \
    texlive-generic-recommended \
    pandoc \
    libspatialindex-dev \
    nmap \
    gfortran

COPY python_additions.sh .

RUN bash python_additions.sh

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
