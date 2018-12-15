#!/usr/bin/env bash

# Standard pip-installed packages go here
## Infrastructure/Utilities
python3 -m pip install --upgrade pip setuptools wheel
python3 -m pip install virtualenv
python3 -m pip install botocore
python3 -m pip install boto3
python3 -m pip install awscli
python3 -m pip install bs4

## Data Extraction/Managing
python3 -m pip install minio
python3 -m pip install pyhdb
python3 -m pip install pyodbc
python3 -m pip install pandas
python3 -m pip install Xlsxwriter, openpyxl, xlrd, pyexcel
python3 -m pip install yattag

## Machine Learning
python3 -m pip install tensorflow
python3 -m pip install scipy
python3 -m pip install sklearn
python3 -m pip install pyenchant
python3 -m pip install nltk
python3 -m pip install python-Levenshtein
python3 -m pip install fbprophet

## Plotting
python3 -m pip install matplotlib
python3 -m pip install ipyleaflet
python3 -m pip install wordcloud
python3 -m pip install bokeh

## Geospatial
python3 -m pip install h3
python3 -m pip install folium
python3 -m pip install geojson-utils
python3 -m pip install shapely

# Non-standard packages go here
python3 -c "import nltk;nltk.download('averaged_perceptron_tagger');nltk.download('punkt');nltk.download('stopwords')"
