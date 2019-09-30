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
python3 -m pip install jupyterlab-git
jupyter serverextension enable --py jupyterlab_git --sys-prefix

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

# plotly
## Avoid "JavaScript heap out of memory" errors during extension installation
export NODE_OPTIONS=--max-old-space-size=4096

## jupyterlab renderer support
jupyter labextension install jupyterlab-plotly@1.1.0

## FigureWidget support
jupyter labextension install plotlywidget@1.1.0

## JupyterLab chart editor support (optional)
#jupyter labextension install jupyterlab-chart-editor@1.2

## Unset NODE_OPTIONS environment variable
unset NODE_OPTIONS
