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

# Clone common repos into home directory
if [[ $COCT_CONTAINER == "yes" ]]; then
  echo "cloning in CoCT standard repos"...
  cd /home/$NEWUSER && /usr/bin/git clone https://ds1.capetown.gov.za/ds_gitlab/OPM/db-utils.git
  # to do - create a samples/tutorials repo and clone it in
  # to do - create a user manual repo and clone it in
fi


# Clone a project git repo into the /home/$NEWUSER folder
if [[ $GITREPO != "" ]]; then
  echo cloning $GITREPO...
  cd /home/$NEWUSER && /usr/bin/git clone $GITREPO
fi

# Configure git username and email so that we don't have to do it every time
if [[ $GITUSER == "" ]]; then
  echo "No GITUSER set. Assuming $NEWUSER is also the GITUSER."
  GITUSER=$NEWUSER
fi
if [[ $GITEMAIL == "" ]]; then
  echo "No GITEMAIL set. Using $GITUSER as GITEMAIL."
  GITEMAIL=$GITUSER
fi
echo "Setting up .gitconfig"
echo "[user]
     name = $GITUSER
     email = $GITEMAIL" >> /home/$NEWUSER/.gitconfig

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
