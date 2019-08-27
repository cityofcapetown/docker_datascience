FROM cityofcapetown/datascience:python_minimal

LABEL authors="Riaz Arbi,Gordon Inggs"

# Additional Python dependencies
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update && \
    apt-get install -y \
    enchant libenchant-dev \
    libfreetype6-dev \
    pkg-config \
    libpng-dev

COPY python_additions.sh .

RUN bash python_additions.sh
