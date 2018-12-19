FROM cityofcapetown/datascience:R_nonstandard

LABEL authors="Riaz Arbi,Gordon Inggs"

# Install rstudio
COPY rstudio_additions.sh .
RUN bash rstudio_additions.sh

COPY run_rstudio.sh /run_scripts/
RUN chmod +x /run_scripts/run_rstudio.sh

COPY rstudio.conf /etc/nginx/paths-available/

# Installing Shiny
COPY shiny_additions.sh .
RUN bash shiny_additions.sh
COPY shiny-server.conf /etc/shiny-server/shiny-server.conf

COPY run_shiny.sh /run_scripts/
RUN chmod +x /run_scripts/run_shiny.sh

COPY shiny.conf /etc/nginx/paths-available/
