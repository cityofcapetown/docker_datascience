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
python3 -m pip install pyodbc
python3 -m pip install bs4
python3 -m pip install pandas, setuptools, Xlsxwriter, openpyxl, xlrd, pyexcel


# Non-standard packages go here
jupyter nbextension enable --py --sys-prefix ipyleaflet
jupyter nbextension enable --py widgetsnbextension
jupyter labextension install jupyter-leaflet
jupyter labextension install @jupyter-widgets/jupyterlab-manager

# Selenium headless browser
# Firefox driver
wget https://github.com/mozilla/geckodriver/releases/download/v0.21.0/geckodriver-v0.21.0-linux64.tar.gz -O geckodriver.tar.gz
tar -xzf geckodriver.tar.gz
rm -rf geckodriver.tar.xz
mv geckodriver /usr/bin/geckodriver
# Headless X environment
apt-get update
apt install -y chromium-browser \
               xvfb \
               firefox \
               libdbus-glib-1-2 \
               libgtk2.0-0 \
               libasound2
# Python packages
python3 -m pip install pyvirtualdisplay
python3 -m pip install selenium

