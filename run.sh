# Create new user
echo
echo adding user $NEWUSER...
useradd -ms /bin/bash $NEWUSER
# Change user password from default
echo setting $NEWUSER password...
echo $NEWUSER:$PASSWD | chpasswd
# Grant new user sudo if ENV says so
if [[ $SUDO = "yes" ]]; then 
echo $NEWUSER is sudo...
adduser $NEWUSER sudo ; fi

# Clone a project git repo into the /home/$NEWUSER folder
echo cloning $GITREPO...
cd /home/$NEWUSER && /usr/bin/git clone $GITREPO
# Sort out permissions for git git folder
chown -R $NEWUSER:$NEWUSER /home/$NEWUSER
echo

# Make the new user an admin user of Jupyterhub
sed -i "/c.Authenticator.admin_users/c\c.Authenticator.admin_users = {'$NEWUSER'}" /etc/jupyterhub/jupyterhub_config.py
# Set the jupyter base url
# If there is a VIRTUAL_PATH set this sed will run again in the if block lower down.
sed -i "/c.JupyterHub.bind_url/c\c.JupyterHub.bind_url = 'http://:8000/jupyter/'" /etc/jupyterhub/jupyterhub_config.py

# Fix NGINX hostname for dynamic routing
if [[ $VIRTUAL_PATH = "/" ]]; then
    echo "VIRTUAL PATH IS ROOT. NOT MODIFYING NGINX CONF..."
else
    echo The url subpath for this container is $VIRTUAL_PATH
    # Fix RStudio redirect
    sed -i "\/proxy_redirect http\:\/\/localhost\:8787\//c\proxy_redirect http\:\/\/localhost\:8787\/ \$scheme\:\/\/\$host$VIRTUAL_PATH\/rstudio\/\;" /etc/nginx/sites-available/default
    # Fix Jupyter redirect
    sed -i "\/proxy_pass http\:\/\/localhost\:8000/c\proxy_pass http\:\/\/\localhost\:\8000$VIRTUAL_PATH\/jupyter\/\;" /etc/nginx/sites-available/default
    sed -i "/c.JupyterHub.bind_url/c\c.JupyterHub.bind_url = 'http://:8000$VIRTUAL_PATH/jupyter/'" /etc/jupyterhub/jupyterhub_config.py
fi

# Start nginx
echo starting nginx...
nginx &

# Use this code block in production
# Run cron
echo starting cron...
cron &
# Run shiny
if [[ $SHINY = "yes" ]]; then 
echo starting shiny server...
shiny-server &> /dev/null & fi
# Run Rstudio
if [[ $RSTUDIO = "yes" ]]; then 
echo starting rstudio server...
rstudio-server start &> /dev/null & fi
# Run jupyter
if [[ $JUPYTER = "yes" ]]; then 
echo starting jupyterhub...
jupyterhub -f /etc/jupyterhub/jupyterhub_config.py &> /dev/null & fi
# Drop privileges to sudo user and enter bash
echo dropping from root...
read -n 1 -s -r -p "Press any key to kill...  `echo $'\n \n \n> '`"

# Use this code block in testing
# Run shiny
#shiny-server &> /dev/null &
# Run Rstudio
#rstudio-server start  &> /dev/null &
# Run jupyter
#jupyterhub -f /etc/jupyterhub/jupyterhub_config.py #&> /dev/null &
# Drop privileges to sudo user and enter bash
#read -n 1 -s -r -p "Press any key to quit...  `echo $'\n \n \n> '`"
#tail -f /var/log/nginx/error.log
#/bin/bash
