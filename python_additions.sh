# Standard pip-installed packages go here
python3 -m pip install --upgrade pip setuptools wheel
python3 -m pip install virtualenv
python3 -m pip install tensorflow
python3 -m pip install botocore
python3 -m pip install boto3
python3 -m pip install awscli
python3 -m pip install minio
python3 -m pip install pyhdb
python3 -m pip install matplotlib
python3 -m pip install scipy
python3 -m pip install sklearn
python3 -m pip install ipyleaflet
python3 -m pip install geojson-utils

# Non-standard packages go here
jupyter nbextension enable --py --sys-prefix ipyleaflet
jupyter nbextension enable --py widgetsnbextension
jupyter labextension install jupyter-leaflet
jupyter labextension install @jupyter-widgets/jupyterlab-manager
