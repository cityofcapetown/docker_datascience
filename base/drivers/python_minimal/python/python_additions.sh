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
python3 -m pip install docker
python3 -m pip install paramiko
python3 -m pip install pysftp

## Data Extraction/Managing
python3 -m pip install XlsxWriter
python3 -m pip install openpyxl
python3 -m pip install xlrd
python3 -m pip install pyexcel
python3 -m pip install yattag
python3 -m pip install psycopg2-binary
python3 -m pip install elasticsearch
python3 -m pip install "elasticsearch-dsl>=7.0.0,<8.0.0"
python3 -m pip install shareplum
python3 -m pip install exchangelib
python3 -m pip install requests
python3 -m pip install requests_ntlm
python3 -m pip install beautifulsoup4

## Machine Learning
python3 -m pip install statsmodels
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
python3 -m pip install spacy

## Plotting
python3 -m pip install matplotlib
python3 -m pip install wordcloud
python3 -m pip install bokeh
python3 -m pip install folium
python3 -m pip install seaborn
python3 -m pip install plotly==4.1.0
python3 -m pip install dash==1.3.0
python3 -m pip install dash-daq==0.1.0
python3 -m pip install dash-bootstrap-components
python3 -m pip install pandoc

## Geospatial
python3 -m pip install h3
python3 -m pip install folium
python3 -m pip install geojson-utils
python3 -m pip install shapely
python3 -m pip install geopandas
python3 -m pip install descartes
python3 -m pip install geocoder
python3 -m pip install rtree

# Non-standard packages go here
python3 -m spacy download en
python3 -m spacy download en_core_web_lg
