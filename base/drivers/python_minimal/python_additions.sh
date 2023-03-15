#!/usr/bin/env bash

# General utilities
python3 -m pip install --upgrade pip setuptools wheel
python3 -m pip install python-magic
python3 -m pip install cffi

# Data Extraction/Managing
python3 -m pip install minio
python3 -m pip install pyhdb
python3 -m pip install pyodbc
python3 -m pip install numpy
python3 -m pip install Cython 
python3 -m pip install "pyarrow>=5.0.0"
python3 -m pip install "pandas>=1.2.0"
python3 -m pip install python-magic
python3 -m pip install pyhive
python3 -m pip install "botocore<1.28"
python3 -m pip install fsspec
python3 -m pip install "s3fs>=0.5.2"
python3 -m pip install "exchangelib>=3.3.2"
python3 -m pip install "requests>=2.0.0"
python3 -m pip install "requests_ntlm>=1.1.0"
python3 -m pip install "SharePlum>=0.5.1"
python3 -m pip install "trino>=0.306.0"

#Continuous Integration and Continuous Delivery 
python3 -m pip install coverage
python3 -m pip install ruff
python3 -m pip install black
python3 -m pip install pytest

# Internal Packages
host lake.capetown.gov.za
if [ $? -eq 0 ]; then
  python3 -m pip install -r "https://ds1.capetown.gov.za/ds_gitlab/OPM/db-utils/raw/28c1a697eea860e9ce9ffda450a62775978e0463/requirements.txt"
  python3 -m pip install "https://lake.capetown.gov.za/db-utils/db_utils-0.4.4-py2.py3-none-any.whl"
  python3 -m pip install -r "https://ds1.capetown.gov.za/ds_gitlab/OPM/pipeline-utils/raw/master/requirements.txt"
  python3 -m pip install "https://lake.capetown.gov.za/pipeline-utils/pipeline_utils-0.2-py2.py3-none-any.whl"
fi
