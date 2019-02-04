#!/usr/bin/env bash
# jupyter
DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs npm
npm cache clean -f && \
  npm install -g configurable-http-proxy
python3 -m pip install jupyter jupyterlab

# jupyterlab
jupyter serverextension enable --py jupyterlab --sys-prefix

# jupyterlab-widgets
jupyter labextension install @jupyter-widgets/jupyterlab-manager

# jupyterhub
python3 -m pip install jupyterhub
jupyter labextension install @jupyterlab/hub-extension
jupyter labextension enable @jupyterlab/hub-extension

# jupyterlab-git
jupyter labextension install @jupyterlab/git
jupyter labextension enable @jupyterlab/git

# jupyterlab-dicovery
python3 -m pip install jupyterlab-discovery

# ipyleaflet
python3 -m pip install ipyleaflet
jupyter nbextension enable --py --sys-prefix ipyleaflet
jupyter nbextension enable --py widgetsnbextension
jupyter labextension install jupyter-leaflet


# jupyter-matplotlib
python3 -m pip install ipympl
jupyter labextension install jupyter-matplotlib