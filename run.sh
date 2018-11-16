# Create new user
useradd -ms /bin/bash $NEWUSER
# Change user password from default
echo $NEWUSER:$PASSWD | chpasswd
# Grant new user sudo if ENV says so
if [[ $SUDO = "yes" ]]; then adduser $NEWUSER sudo ; fi

# Clone a project git repo into the /home/$NEWUSER folder
cd /home/$NEWUSER && /usr/bin/git clone $GITREPO
# Sort out permissions for git git folder
chown -R $NEWUSER:$NEWUSER /home/$NEWUSER

# Make the new user an admin user of Jupyterhub
sed -i "/c.Authenticator.admin_users/c\c.Authenticator.admin_users = {'$NEWUSER'}" /etc/jupyterhub/jupyterhub_config.py
# Set the jupyter base url
sed -i "/c.JupyterHub.base_url/c\c.JupyterHub.base_url = '/jupyter'" /etc/jupyterhub/jupyterhub_config.py

# Fix NGINX hostname for dynamic routing
echo $VIRTUAL_PATH
if [[ $VIRTUAL_PATH = "/" ]]; then
    echo "VIRTUAL PATH IS ROOT. NOT MODIFYING NGINX CONF"
else
    # Fix RStudio redirect
    sed -i "\/proxy_redirect http\:\/\/localhost\:8787\//c\proxy_redirect http\:\/\/localhost\:8787\/ \$scheme\:\/\/\$host$VIRTUAL_PATH\/rstudio\/\;" /etc/nginx/sites-available/default
fi

# Start nginx
nginx &

# Use this code block in production
# Run cron
cron &
# Run shiny
#if [[ $SHINY = "yes" ]]; then shiny-server &> /dev/null & fi
# Run Rstudio
#if [[ $RSTUDIO = "yes" ]]; then rstudio-server start &> /dev/null & fi
# Run jupyter
#if [[ $JUPYTER = "yes" ]]; then jupyterhub -f /etc/jupyterhub/jupyterhub_config.py &> /dev/null & fi
# Drop privileges to sudo user and enter bash
#read -n 1 -s -r -p "Press any key to quit...  `echo $'\n \n \n> '`"

# Use this code block in testing
# Run shiny
shiny-server &> /dev/null &
# Run Rstudio
rstudio-server start  &> /dev/null &
# Run jupyter
jupyterhub -f /etc/jupyterhub/jupyterhub_config.py &> /dev/null &
# Drop privileges to sudo user and enter bash
#read -n 1 -s -r -p "Press any key to quit...  `echo $'\n \n \n> '`"
/bin/bash
