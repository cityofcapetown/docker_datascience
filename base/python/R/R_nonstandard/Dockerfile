FROM cityofcapetown/datascience:R

LABEL authors="Riaz Arbi,Gordon Inggs"

COPY R_nonstandard.R .

RUN MAKEFLAGS="-j" Rscript R_nonstandard.R
