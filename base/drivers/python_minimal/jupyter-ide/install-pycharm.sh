#!/usr/bin/env bash
set -e

NB_UID=$1
NB_GID=$2

mkdir -p /opt/pycharm
curl -L "https://download.jetbrains.com/product?code=PCC&latest&distribution=linux" \
| tar -C /opt/pycharm --strip-components 1 -xzvf -

# Make The idea.properties editable by the user that has started jupyter/jupyterlab/jupyterhub
chown $NB_UID:$NB_GID /opt/pycharm/bin/idea.properties

# Add a binary to the PATH that points to the IDE startup script.
ln -s /opt/pycharm/bin/pycharm.sh /usr/bin/pycharm
