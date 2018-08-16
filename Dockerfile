FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y \
    git \
    cron \
    sudo \
    nano
    
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
RUN n stable
RUN npm -v

RUN npm install -g configurable-http-proxy
RUN pip3 install jupyterhub
RUN pip3 install --upgrade notebook

RUN jupyterhub --generate-config
RUN sed -i "/c.Authenticator.admin_users/c\c.Authenticator.admin_users = {\'$newuser\'}" ~/jupyterhub_config.py

RUN pip3 install jupyterlab
RUN jupyter serverextension enable --py jupyterlab --sys-prefix
RUN jupyter labextension install @jupyterlab/hub-extension
RUN sed -i "/c.Spawner.default_url/c\c.Spawner.default_url = '/lab'" ~/jupyterhub_config.py
RUN sed -i "/c.Spawner.cmd/c\c.Spawner.cmd = ['jupyter-labhub']" ~/jupyterhub_config.py

RUN cp ~/jupyterhub_config.py /etc/jupyterhub/
RUN chown root:root /etc/jupyterhub/jupyterhub_config.yp
RUN chmod 0644 /etc/jupyterhub/jupyterhub_config.py
COPY jupyterhub.service /
RUN mv /jupyterhub.service /etc/systemd/system/jupyterhub.service
RUN cp /etc/systemd/system/jupyterhub.service /lib/systemd/system/jupyterhub.service
RUN systemctl enable jupyterhub
EXPOSE 8000


USER $NEWUSER
WORKDIR /home/$NEWUSER
