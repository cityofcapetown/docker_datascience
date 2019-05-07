#!/usr/bin/env bash

# Standard pip-installed packages go here
## Infrastructure/Utilities
python3 -m pip install --upgrade pip setuptools wheel
python3 -m pip install virtualenv
python3 -m pip install botocore
python3 -m pip install boto3
python3 -m pip install awscli
python3 -m pip install bs4
python3 -m pip install convertdate
python3 -m pip install holidays
python3 -m pip install tqdm
python3 -m pip install pyvirtualdisplay
python3 -m pip install selenium
python3 -m pip install pybind11
python3 -m pip install shareplum
python3 -m pip install exchangelib
python3 -m pip install docker

## Data Extraction/Managing
python3 -m pip install minio
python3 -m pip install pyhdb
python3 -m pip install pyodbc
python3 -m pip install pandas
python3 -m pip install XlsxWriter
python3 -m pip install openpyxl
python3 -m pip install xlrd
python3 -m pip install pyexcel
python3 -m pip install yattag
python3 -m pip install psycopg2-binary

## Machine Learning
python3 -m pip install tensorflow
python3 -m pip install scipy
python3 -m pip install sklearn
python3 -m pip install pyenchant
python3 -m pip install nltk
python3 -m pip install python-Levenshtein
python3 -m pip install pystan
python3 -m pip install fbprophet
python3 -m pip install torch
python3 -m pip install torchvision

## Plotting
python3 -m pip install matplotlib
python3 -m pip install wordcloud
python3 -m pip install bokeh
python3 -m pip install folium

## Geospatial
python3 -m pip install h3
python3 -m pip install folium
python3 -m pip install geojson-utils
python3 -m pip install shapely
python3 -m pip install geopandas

# Non-standard packages go here
python3 -c "import nltk;nltk.download('averaged_perceptron_tagger');nltk.download('punkt');nltk.download('stopwords')"

