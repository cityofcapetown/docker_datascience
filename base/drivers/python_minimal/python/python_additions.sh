#!/usr/bin/env bash
set -e

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
python3 -m pip install selenium-wire
python3 -m pip install "pyopenssl==22.0.0"
python3 -m pip install pybind11
python3 -m pip install docker
python3 -m pip install paramiko
python3 -m pip install progressbar
python3 -m pip install pysftp
python3 -m pip install LunarCalendar
python3 -m pip install "markupsafe==2.0.1"

## Data Extraction/Managing
python3 -m pip install polars
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
python3 -m pip install html5lib
python3 -m pip install numba
python3 -m pip install treelib
python3 -m pip install ujson
python3 -m pip install sxl

## Machine Learning
python3 -m pip install statsmodels
python3 -m pip install tensorflow
python3 -m pip install scipy
python3 -m pip install sklearn
python3 -m pip install python-Levenshtein
python3 -m pip install "pystan==2.19.1.1"
python3 -m pip install fbprophet
python3 -m pip install torch
python3 -m pip install torchvision
python3 -m pip install spacy
python3 -m pip install pymc3
python3 -m pip install PM4Py
python3 -m pip install darts
python3 -m pip install "fastai==2.7.4"

## Plotting
python3 -m pip install matplotlib
python3 -m pip install wordcloud
python3 -m pip install "bokeh==2.4.3"
python3 -m pip install folium
python3 -m pip install seaborn
python3 -m pip install "plotly==4.1.0"
python3 -m pip install "dash==1.3.0"
python3 -m pip install "dash-daq==0.1.0"
python3 -m pip install dash-bootstrap-components
python3 -m pip install pandoc
python3 -m pip install pretty_html_table
python3 -m pip install graphviz

## Geospatial
python3 -m pip install h3
python3 -m pip install folium
python3 -m pip install geojson-utils
python3 -m pip install pystac_client
python3 -m pip install shapely
python3 -m pip install geopandas
python3 -m pip install descartes
python3 -m pip install geocoder
python3 -m pip install rtree
python3 -m pip install geopy

## Continuous Integration and Continuous Delivery 
python3 -m pip install coverage
python3 -m pip install ruff
python3 -m pip install black

if [ $(host lake.capetown.gov.za) -neq 0 ]; then
  python3 -m pip install git+https://github.com/opendatadurban/geocode-array.git
fi

python3 -m pip install mapclassify
# python3 -m pip install cartopy

# Internal Packages
host lake.capetown.gov.za
if [ $? -eq 0 ]; then
  python3 -m pip install "https://lake.capetown.gov.za/geospatial-utils/geospatial_utils-0.3.0rc1-py3-none-any.whl"
fi

# Non-standard packages go here
python3 -m spacy download en_core_web_sm
python3 -m spacy download en_core_web_lg
