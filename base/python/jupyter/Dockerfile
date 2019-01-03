FROM cityofcapetown/datascience:python

LABEL authors="Riaz Arbi,Gordon Inggs"

COPY jupyter_additions.sh .
RUN bash jupyter_additions.sh

COPY jupyter.conf /etc/nginx/paths-available/

COPY run_jupyter.sh /run_scripts/
RUN chmod +x /run_scripts/run_jupyter.sh
