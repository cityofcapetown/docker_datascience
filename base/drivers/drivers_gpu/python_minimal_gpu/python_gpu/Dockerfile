# This Dockerfile is identical to the one in base/drivers/python, with the exception of the FROM line
FROM cityofcapetown/datascience:python_minimal_gpu

LABEL authors="Riaz Arbi,Gordon Inggs"

# Additional Python dependencies
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update && \
    apt-get install -y \
    enchant libenchant-dev \
    libfreetype6-dev \
    pkg-config \
    libpng-dev

COPY python_additions.sh /
COPY python_gpu_additions.sh .

RUN bash python_gpu_additions.sh
