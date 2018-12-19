#!/usr/bin/env bash

# Fixing RStudio redirect
sed -i "\/proxy_redirect http\:\/\/localhost\:8787\//c\proxy_redirect http\:\/\/localhost\:8787\/ http\:\/\/\$host$VIRTUAL_PATH\/rstudio\/\;" /etc/nginx/paths-available/rstudio.conf
sed -i "\/proxy_redirect https\:\/\/localhost\:8787\//c\proxy_redirect https\:\/\/localhost\:8787\/ https\:\/\/\$host$VIRTUAL_PATH\/rstudio\/\;" /etc/nginx/paths-available/rstudio.conf

echo "Starting RStudio..."
rstudio-server start &