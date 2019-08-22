# This Dockerfile is identical to the one in base/drivers/python, with the exception of the FROM line
FROM cityofcapetown/datascience:drivers_gpu

LABEL authors="Riaz Arbi,Gordon Inggs"

# These are packages used in both Python and R.
RUN DEBIAN_FRONTEND=noninteractive \
  apt-get clean && \
  apt-get update && \
  apt-get install -y \
  python3 \
  python3-pip

COPY python_additions.sh .

RUN bash python_additions.sh
