FROM ubuntu:18.04

# Expose ports
EXPOSE 8000
EXPOSE 8787
EXPOSE 3838
EXPOSE 54321
EXPOSE 54322

# Set variables
ENV NEWUSER=newuser
ENV PASSWD=password
ENV GITREPO=https://github.com/riazarbi/workspace_template.git
ENV JUPYTER=yes
ENV RSTUDIO=yes
ENV SHINY=yes
ENV H2O=yes

# Install base utility packages
RUN apt-get update && \
    apt-get dist-upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -qq install tzdata apt-utils
RUN ln -fs /usr/share/zoneinfo/Africa/Johannesburg /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-get install -y \
    git \
    cron \
    sudo \
    nano \
    wget \
    htop && \
    apt-get clean

# Install jupyterhub dependencies
RUN apt-get install -y \
    nodejs \
    python3-pip && \
    apt-get clean
RUN apt-get install -y \
    npm && \
    apt-get clean
    
RUN npm cache clean -f
RUN npm -v

RUN npm install -g configurable-http-proxy
RUN pip3 install jupyterhub
RUN pip3 install --upgrade notebook
RUN pip3 install jupyterlab

# Configure jupyterhub
RUN jupyterhub --generate-config

RUN jupyter serverextension enable --py jupyterlab --sys-prefix
RUN jupyter labextension install @jupyterlab/hub-extension

RUN sed -i "/c.Authenticator.admin_users/c\c.Authenticator.admin_users = {\'$NEWUSER\'}" /jupyterhub_config.py
RUN sed -i "/c.Spawner.default_url/c\c.Spawner.default_url = '/lab'" /jupyterhub_config.py
RUN sed -i "/c.Spawner.cmd/c\c.Spawner.cmd = ['jupyter-labhub']" /jupyterhub_config.py
RUN mkdir /etc/jupyterhub
RUN mv /jupyterhub_config.py /etc/jupyterhub/
RUN chown root:root /etc/jupyterhub/jupyterhub_config.py
RUN chmod 0644 /etc/jupyterhub/jupyterhub_config.py

# Install R
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9 && \
    echo "# CRAN Repo" | sudo tee -a /etc/apt/sources.list && \
    echo "deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/" | sudo tee -a /etc/apt/sources.list && \
    apt-get install r-base -y && \ 
    apt-get clean

# Install Miktex
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D6BC243565B2087BC3F897C9277A7293F59E4889 && \
    echo "deb http://miktex.org/download/ubuntu bionic universe" | sudo tee /etc/apt/sources.list.d/miktex.list && \
    apt-get update && \
    apt-get install -y \
    miktex && \
    apt-get clean

# Install and setup Rstudio Server
RUN apt-get install gdebi-core dpkg -y
RUN wget https://download2.rstudio.org/rstudio-server-1.1.456-amd64.deb -O rs-latest.deb
RUN gdebi -n rs-latest.deb
RUN rm -f rs-latest.deb

# Install and setup shiny
RUN apt-get install -y \
    pandoc \
    pandoc-citeproc && \
    apt-get clean

RUN wget "https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-1.5.7.907-amd64.deb" -O ss-latest.deb
RUN gdebi -n ss-latest.deb
RUN rm -f ss-latest.deb
RUN R -e "install.packages(c('shiny', 'rmarkdown'), repos='https://cran.rstudio.com/')" 
RUN cp -R /usr/local/lib/R/site-library/shiny/examples/* /srv/shiny-server/
RUN rm -rf /var/lib/apt/lists/*
#COPY shiny-customized.config /etc/shiny-server/shiny-server.conf

# Install additional nonessential packages
# You can comment out these three bash scripts and still have a working container
#RUN sudo pip3 install minio
COPY apt_additions.sh .
COPY R_additions.R .
COPY python_additions.sh .

RUN bash apt_additions.sh
RUN bash python_additions.sh
RUN Rscript R_additions.R

# Install tini to run entrypoint command
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

# Build startup script
# Create new user
RUN echo 'useradd -ms /bin/bash $NEWUSER' >> /run.sh
# Change user password from default
RUN echo 'echo $NEWUSER:$PASSWD | chpasswd' >> /run.sh
# Grant new user sudo
RUN echo 'adduser $NEWUSER sudo' >> /run.sh
# Clone a project git repo into the /home/$NEWUSER folder
RUN echo "cd /home/$NEWUSER && /usr/bin/git clone $GITREPO" >>  /run.sh
# Sort out permissions
RUN echo "chown -R $NEWUSER:$NEWUSER /home/$NEWUSER" >> /run.sh
# Run shiny
RUN echo "shiny-server &" >> /run.sh
# Run rstudio
RUN echo "rstudio-server start &" >> /run.sh
# Run jupyter
RUN echo "jupyterhub -f /etc/jupyterhub/jupyterhub_config.py" >> /run.sh
RUN chmod +x /run.sh

# Run startup script on runtime
#CMD ["/run.sh"]


# Change working directory to $NEWUSER
#USER $NEWUSER
#WORKDIR /home/$NEWUSER

# ISSUES #
# RUN MORE SECURELY, NOT AS ROOT
# DROP DOWN PRIVILEGES TO UNPRIVILEGED USER
# ALLOW FOR PASSWORD CHANGE FOR ADMIN USER AT RUNTIME
# ADD ENV VARIABLES TO CHOOSE WHAT SERVICES TO EXPOSE
# CLONE GIT REPO AUTOMATICALLY
