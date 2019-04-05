FROM cityofcapetown/datascience:R

LABEL authors="Riaz Arbi,Gordon Inggs"

# Expose 54321 so we can access h2o webUI
EXPOSE 54321

RUN apt-get update && \
    apt-get install cmake make gcc -y && \
    apt-get clean

RUN git clone --single-branch --branch "feature/hex-ring" https://github.com/crazycapivara/h3-r.git \
    && cd h3-r \
    && chmod +x install-h3c.sh \
    && bash ./install-h3c.sh \
    && R -q -e 'devtools::install()' \
    && cd .. \
    && rm -rf h3-r

COPY R_nonstandard.R .

RUN MAKEFLAGS="-j" Rscript R_nonstandard.R
