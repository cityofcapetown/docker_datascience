FROM cityofcapetown/datascience:drivers as drivers-image

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

FROM drivers-image as unit-test

# Minio Utils unit tests
RUN git clone https://ds1.capetown.gov.za/ds_gitlab/OPM/db-utils.git && \
    cd db-utils && rm -rf db_utils && \
    python3 -W ignore:ImportantWarning -m unittest tst.test_minio_utils && \
    python3 -W ignore:ImportantWarning -m unittest tst.test_odbc_utils && \
    python3 -W ignore:ImportantWarning -m unittest tst.test_secrets_utils && \
    python3 -W ignore:ImportantWarning -m unittest tst.test_sharepoint_utils && \
    python3 -W ignore:ImportantWarning -m unittest tst.test_trino_utils && \
    python3 -W ignore:ImportantWarning -m unittest tst.test_minio_utils_base_funcs && \
    python3 -W ignore:ImportantWarning -m unittest tst.test_minio_utils_df_funcs && \
    cd / && rm -rf /db-utils

# Pipeline Utils unit tests
RUN git clone https://ds1.capetown.gov.za/ds_gitlab/OPM/pipeline-utils.git && \
    cd pipeline-utils && rm -rf pipeline_utils && \
    python3 -W ignore:ImportantWarning -m unittest tst.test_kubernetes_dag && \
    cd / && rm -rf pipeline-utils/


FROM unit-test as final-image

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    python3 -m pip cache purge
