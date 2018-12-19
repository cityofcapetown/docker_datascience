#!/usr/bin/env bash

# Fixing Shiny redirect
sed -i "\/rewrite \^\/shiny\$/c\/rewrite \^\/shiny\$ \$scheme\:\/\/\$http_host$VIRTUAL_PATH\/shiny\/ permanent;"
sed -i "\/proxy_redirect http\:\/\/localhost\:3838\//c\proxy_redirect http\:\/\/localhost\:3838\/ http\:\/\/\$host$VIRTUAL_PATH\/shiny\/\;" /etc/nginx/paths-available/shiny.conf
sed -i "\/proxy_redirect https\:\/\/localhost\:3838\//c\proxy_redirect https\:\/\/localhost\:3838\/ https\:\/\/\$host$VIRTUAL_PATH\/shiny\/\;" /etc/nginx/paths-available/shiny.conf

echo "Starting Shiny..."
shiny-server &