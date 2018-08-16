FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y \
    git \
    cron \
    sudo \
    nano \
    wget
    
ENV NEWUSER=newuser
ENV PASSWD=passwd

RUN useradd -ms /bin/bash $NEWUSER
RUN echo 'newuser:password' | chpasswd
RUN adduser $NEWUSER sudo
RUN apt-get install htop -y
RUN apt-get install python3-pip -y
RUN apt-get install npm nodejs-legacy -y

RUN npm -v
RUN npm cache clean -f
#RUN n stable
RUN npm -v

RUN npm install -g configurable-http-proxy
RUN pip3 install jupyterhub
RUN pip3 install --upgrade notebook

RUN jupyterhub --generate-config
#RUN sed -i "/c.Authenticator.admin_users/c\c.Authenticator.admin_users = {\'$newuser\'}" ~/jupyterhub_config.py

RUN pip3 install jupyterlab
RUN jupyter serverextension enable --py jupyterlab --sys-prefix
RUN jupyter labextension install @jupyterlab/hub-extension
#RUN sed -i "/c.Spawner.default_url/c\c.Spawner.default_url = '/lab'" ~/jupyterhub_config.py
#RUN sed -i "/c.Spawner.cmd/c\c.Spawner.cmd = ['jupyter-labhub']" ~/jupyterhub_config.py

#RUN cp ~/jupyterhub_config.py /etc/jupyterhub/
RUN chown root:root /etc/jupyterhub/jupyterhub_config.yp
RUN chmod 0644 /etc/jupyterhub/jupyterhub_config.py

COPY jupyterhub.service /
RUN mv /jupyterhub.service /etc/systemd/system/jupyterhub.service
RUN cp /etc/systemd/system/jupyterhub.service /lib/systemd/system/jupyterhub.service
RUN systemctl enable jupyterhub
EXPOSE 8000

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

RUN echo "# CRAN Repo" | sudo tee -a /etc/apt/sources.list
RUN echo "deb https://cloud.r-project.org/bin/linux/ubuntu xenial/" | sudo tee -a /etc/apt/sources.list

RUN apt-get update
RUN apt-get install r-base -y
RUN apt-get install gdebi-core dpkg -y

RUN wget https://download2.rstudio.org/rstudio-server-1.1.383-amd64.deb

RUN gdebi --non-interactive rstudio-server-1.1.383-amd64.deb

RUN systemctl start rstudio-server
RUN systemctl enable rstudio-server

EXPOSE 8787

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D6BC243565B2087BC3F897C9277A7293F59E4889
RUN "deb http://miktex.org/download/ubuntu xenial universe" | sudo tee /etc/apt/sources.list.d/miktex.list
RUN apt-get update
RUN apt-get install miktex -y

USER $NEWUSER
WORKDIR /home/$NEWUSER
