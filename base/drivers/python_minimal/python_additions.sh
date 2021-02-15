#!/usr/bin/env bash
set -e

# General utilities
python3 -m pip install --upgrade pip setuptools wheel
python3 -m pip install python-magic

# Data Extraction/Managing
python3 -m pip install minio
python3 -m pip install pyhdb
python3 -m pip install pyodbc
python3 -m pip install numpy
python3 -m pip install Cython 
python3 -m pip install "pyarrow>=3.0.0"
python3 -m pip install "pandas>=1.2.0"
python3 -m pip install python-magic
python3 -m pip install pyhive
python3 -m pip install fsspec
python3 -m pip install "s3fs>=0.5.2"
python3 -m pip install "exchangelib>=3.3.2"
python3 -m pip install "requests_ntlm>=2.0.0"
python3 -m pip install "requests_ntlm>=1.1.0"
python3 -m pip install "SharePlum>=0.5.1"
