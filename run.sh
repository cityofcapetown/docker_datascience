# Create new user
useradd -ms /bin/bash $NEWUSER
# Change user password from default
echo $NEWUSER:$PASSWD | chpasswd
# Grant new user sudo
adduser $NEWUSER sudo

# Clone a project git repo into the /home/$NEWUSER folder
cd /home/$NEWUSER && /usr/bin/git clone $GITREPO
# Sort out permissions for git git folder
chown -R $NEWUSER:$NEWUSER /home/$NEWUSER

# Make the new user an admin user of Jupyterhub
sed -i "/c.Authenticator.admin_users/c\c.Authenticator.admin_users = {'\$NEWUSER\'}" /etc/jupyterhub/jupyterhub_config.py
#sed -i "/c.Authenticator.admin_users/c\c.Authenticator.admin_users = {\'$username\'}" ~/jupyterhub_config.py
# Run shiny
if [[ $SHINY = "yes" ]]; then shiny-server &> /dev/null & fi
# Run Rstudio
if [[ $RSTUDIO = "yes" ]]; then rstudio-server start &> /dev/null & fi
# Run jupyter
if [[ $JUPYTER = "yes" ]]; then jupyterhub -f /etc/jupyterhub/jupyterhub_config.py &> /dev/null & fi
# Drop privileges to sudo user and enter bash
read -n 1 -s -r -p "Press any key to quit...  `echo $'\n \n \n> '`"

