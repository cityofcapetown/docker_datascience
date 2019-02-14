# This Dockerfile is identical to the one in base/drivers/python/jupyter, with the exception of the FROM line
FROM cityofcapetown/datascience:python_gpu

LABEL authors="Riaz Arbi,Gordon Inggs"

COPY jupyter_additions.sh .
RUN bash jupyter_additions.sh

COPY jupyter.conf /etc/nginx/paths-available/

COPY run_jupyter.sh /run_scripts/
RUN chmod +x /run_scripts/run_jupyter.sh
