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
  # Sort out permissions for git folder
  chown -R $NEWUSER:$NEWUSER /home/$NEWUSER
  echo
fi

# Fix NGINX hostname for dynamic routing
if [[ $VIRTUAL_PATH = "/" ]]; then
    echo "VIRTUAL PATH IS ROOT. NOT MODIFYING NGINX CONF..."
else
    echo The url subpath for this container is $VIRTUAL_PATH
fi

# Start nginx
echo starting nginx...
nginx -g 'daemon off;' 

