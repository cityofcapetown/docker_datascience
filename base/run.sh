#!/usr/bin/env bash

# Create new user
echo
echo adding user "$NEWUSER"...
useradd -ms /bin/bash $NEWUSER
# Change user password from default
echo setting "$NEWUSER" password...
echo $NEWUSER:$PASSWD | chpasswd

# Grant new user sudo if ENV says so
if [[ $SUDO = "yes" ]]; then 
  echo $NEWUSER is sudo...
  adduser $NEWUSER sudo 
fi

# Clone a project git repo into the /home/$NEWUSER folder
if [[ $GITREPO != "" ]]; then
  echo cloning $GITREPO...
  cd /home/$NEWUSER && /usr/bin/git clone $GITREPO
fi

# Configure git username and email so that we don't have to do it every time
sudo -u $NEWUSER git config --global user.email $NEWUSER
sudo -u $NEWUSER git config --global user.name $NEWUSER

# Sort out permissions for home dir
chown -R $NEWUSER:$NEWUSER /home/$NEWUSER

# Fix NGINX hostname for dynamic routing
if [[ $VIRTUAL_PATH = "/" ]]; then
    echo "VIRTUAL PATH IS ROOT. NOT MODIFYING NGINX CONF..."
else
    echo The url subpath for this container is $VIRTUAL_PATH
fi

# RUN any startup scripts in the hook location
for startup_script in $(ls /run_scripts); do
    echo "Running '$startup_script'...)"
    timeout 60 /run_scripts/"$startup_script"
done

# Start nginx
echo starting nginx...
nginx -g 'daemon off;'
