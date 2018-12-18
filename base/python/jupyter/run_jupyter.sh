#!/usr/bin/env bash

JUPYTER_CONFIG=/etc/jupyterhub/jupyterhub_config.py
JUPYTER_NGINX=/etc/nginx/conf.d/jupyter.conf

# Generate jupyterhub config
mkdir -p /etc/jupyterhub
jupyterhub --generate-config
mv /jupyterhub_config.py "$JUPYTER_CONFIG"
chown root:root "$JUPYTER_CONFIG"
chmod 644 "$JUPYTER_CONFIG"

sed -i "/c.Spawner.default_url/c\c.Spawner.default_url = '/lab'" "$JUPYTER_CONFIG"
sed -i "/c.Spawner.cmd/c\c.Spawner.cmd = ['jupyter-labhub']" "$JUPYTER_CONFIG"

# Make the new user an admin user of Jupyterhub
sed -i "/c.Authenticator.admin_users/c\c.Authenticator.admin_users = {'$NEWUSER'}" "$JUPYTER_CONFIG"

# Set the jupyter base url
# If there is a VIRTUAL_PATH set this sed will run again in the if block lower down.
sed -i "/c.JupyterHub.bind_url/c\c.JupyterHub.bind_url = 'http://:8000/jupyter/'" "$JUPYTER_CONFIG"

# Fix NGINX hostname for dynamic routing
if [[ $VIRTUAL_PATH = "/" ]]; then
    echo "VIRTUAL PATH IS ROOT. NOT MODIFYING NGINX CONF..."
else
    echo 'The url subpath for this container is "$VIRTUAL_PATH"'
    sed -i "\/proxy_pass http\:\/\/localhost\:8000/c\proxy_pass http\:\/\/\localhost\:\8000$VIRTUAL_PATH\/jupyter\/\;" $JUPYTER_NGINX
    sed -i "/c.JupyterHub.bind_url/c\c.JupyterHub.bind_url = 'http://:8000$VIRTUAL_PATH/jupyter/'" "$JUPYTER_CONFIG"
fi

echo "Starting jupyterhub..."
jupyterhub -f $JUPYTER_CONFIG &