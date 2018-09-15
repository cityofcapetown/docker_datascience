FROM cityofcapetown/docker_datascience

LABEL maintainer="Riaz Arbi"

# Install additional nonessential packages
# You can comment out these three bash scripts and still have a working container
# Maybe I should put these into a chained Docker image?
COPY apt_additions.sh .
COPY R_additions.R .
COPY python_additions.sh .
COPY selenium_setup.sh .

RUN bash apt_additions.sh
RUN bash python_additions.sh
RUN Rscript R_additions.R
RUN bash selenium_setup.sh
