FROM cityofcapetown/datascience:drivers

LABEL authors="Riaz Arbi,Gordon Inggs"

# These are packages used in both Python and R.
RUN DEBIAN_FRONTEND=noninteractive \
  apt-get clean && \
  apt-get update && \
  apt-get install -y software-properties-common && \
  add-apt-repository -y ppa:ubuntugis/ppa && \
  add-apt-repository -y ppa:deadsnakes/ppa && \
  apt-get update && \
  apt-get install -y python3.9 python3.9-distutils python3.9-dev && \
  update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 1

RUN curl https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py && \
    python3 /tmp/get-pip.py

COPY python_additions.sh .

RUN bash python_additions.sh

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    python3 -m pip cache purge
