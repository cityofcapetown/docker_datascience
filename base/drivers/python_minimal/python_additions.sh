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
python3 -m pip install pyarrow
python3 -m pip install pandas
python3 -m pip install python-magic
python3 -m pip install pyhive

