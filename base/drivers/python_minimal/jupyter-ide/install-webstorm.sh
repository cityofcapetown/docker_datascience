#!/usr/bin/env bash
set -e

NB_UID=$1
NB_GID=$2

mkdir -p /opt/webstorm
curl -L "https://download.jetbrains.com/product?code=WS&latest&distribution=linux" \
| tar -C /opt/webstorm --strip-components 1 -xzvf -

# Make The idea.properties editable by the user that has started jupyter/jupyterlab/jupyterhub
chown $NB_UID:$NB_GID /opt/webstorm/bin/idea.properties

# Add a binary to the PATH that points to the IDE startup script.
ln -s /opt/webstorm/bin/webstorm.sh /usr/bin/webstorm