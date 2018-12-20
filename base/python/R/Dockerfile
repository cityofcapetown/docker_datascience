FROM cityofcapetown/datascience:python

LABEL authors="Riaz Arbi,Gordon Inggs"

# Install R
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 && \
  echo "# CRAN Repo" | tee -a /etc/apt/sources.list && \
  echo "deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/" | tee -a /etc/apt/sources.list

RUN DEBIAN_FRONTEND=noninteractive \
  apt-get clean && \
  apt-get update && \
  apt-get install -y \
  r-base \
  r-base-dev \
  libxml2-dev \
  software-properties-common \
  libssh2-1-dev \
  zlib1g-dev \
  libxml2-dev \
  libssl-dev \
  libv8-3.14-dev \
  libjq-dev \
  libudunits2-dev \
  protobuf-compiler \
  libprotobuf-dev \
  libgdal-dev \
  libtool

COPY R_additions.R .
RUN MAKEFLAGS="-j" Rscript R_additions.R
