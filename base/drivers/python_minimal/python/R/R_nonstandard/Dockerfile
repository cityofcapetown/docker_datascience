FROM cityofcapetown/datascience:R

LABEL authors="Riaz Arbi,Gordon Inggs"

# Expose 54321 so we can access h2o webUI
EXPOSE 54321

COPY R_nonstandard.R .

RUN MAKEFLAGS="-j" Rscript R_nonstandard.R
