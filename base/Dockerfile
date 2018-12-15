FROM ubuntu:18.04

LABEL authors="Riaz Arbi,Gordon Inggs"

COPY apt.sh .
RUN bash apt.sh

# SET UP NGINX
EXPOSE 80
EXPOSE 443
RUN apt-get update && \
    apt-get install nginx -y && \
    apt-get clean

# COPY IN NGINX TEMPLATES
ENV VIRTUAL_PATH=/
COPY nginx.conf .
COPY base.conf .

# MOVE TEMPLATES TO CORRECT PLACE
RUN mv nginx.conf /etc/nginx/nginx.conf
RUN mv base.conf /etc/nginx/conf.d/base.conf
RUN rm /etc/nginx/sites-enabled/default

# BUILD STARTUP SCRIPT
COPY run.sh /
RUN chmod +x /run.sh

# RUN STARTUP SCRIPT
ENV NEWUSER "newuser" 
ENV PASSWD "password"
ENV GITREPO ""
ENV SUDO "no" 
ENV VIRTUAL_PATH "/"
ENV VIRTUAL_HOST "localhost"

CMD ["/bin/bash", "./run.sh"]
