FROM ubuntu:18.04

LABEL authors="Riaz Arbi,Gordon Inggs"

# Utility packages
RUN DEBIAN_FRONTEND=noninteractive \
  apt-get clean && \
  apt-get update && \
  apt-get install -y \
  vim \
  nano \
  htop \
  bash \
  cmake \
  make \
  gcc \
  wget \
  apt-utils \
  git \
  sudo

# Setting the timezone
ENV TZ="Africa/Johannesburg"
RUN echo $TZ > /etc/timezone && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata && \
  rm /etc/localtime && \
  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
  dpkg-reconfigure -f noninteractive tzdata && \
  apt-get clean

# Define en_ZA
RUN DEBIAN_FRONTEND=noninteractive \
  locale-gen en_ZA && \
  locale-gen en_ZA.UTF-8 && \
  update-locale

ENV LANGUAGE en_ZA.UTF-8
ENV LANG en_ZA.UTF-8
ENV LC_ALL en_ZA.UTF-8
ENV LC_CTYPE en_ZA.UTF-8
ENV LC_MESSAGES en_ZA.UTF-8

# SET UP NGINX
EXPOSE 80
EXPOSE 443
RUN apt-get update && \
    apt-get install nginx -y && \
    apt-get clean

# COPY IN NGINX TEMPLATES
COPY nginx.conf .
COPY base.conf .

# MOVE TEMPLATES TO CORRECT PLACE
RUN mv nginx.conf /etc/nginx/nginx.conf
RUN mv base.conf /etc/nginx/conf.d/base.conf
RUN rm /etc/nginx/sites-enabled/default
RUN mkdir -p /etc/nginx/paths-available/

# BUILD STARTUP SCRIPT
COPY run.sh /
RUN chmod +x /run.sh

# CREATING STARTUP SCRIPT HOOK LOCATION
RUN mkdir /run_scripts

# RUN STARTUP SCRIPT
ENV NEWUSER "newuser" 
ENV PASSWD "password"
ENV GITREPO ""
ENV GITUSER ""
ENV GITEMAIL ""
ENV SUDO "no"
ENV VIRTUAL_PATH /
ENV VIRTUAL_HOST "localhost"

CMD ["/bin/bash", "./run.sh"]
