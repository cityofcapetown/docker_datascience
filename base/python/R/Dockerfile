FROM gordonei/docker_datascience:python

LABEL authors="Riaz Arbi,Gordon Inggs"

COPY apt.sh .
COPY R_additions.R .

RUN bash apt.sh
RUN MAKEFLAGS="-j" Rscript R_additions.R
