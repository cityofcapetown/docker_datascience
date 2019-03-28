FROM cityofcapetown/datascience:R

LABEL authors="Riaz Arbi,Gordon Inggs"

# Expose 54321 so we can access h2o webUI
EXPOSE 54321

RUN apt-get update && \
    apt-get install cmake make gcc -y && \
    apt-get clean

COPY R_nonstandard.R .
COPY h3-r.sh .
RUN bash h3-r.sh
RUN MAKEFLAGS="-j" Rscript R_nonstandard.R
