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
USER $NEWUSER
WORKDIR /home/$NEWUSER
