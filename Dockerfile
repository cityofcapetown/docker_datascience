FROM cityofcapetown/docker_datascience

LABEL maintainer="Riaz Arbi"

# Install additional nonessential packages
# You can comment out these three bash scripts and still have a working container
# Maybe I should put these into a chained Docker image?
COPY apt_additions.sh .
COPY R_additions.R .
COPY python_additions.sh .
COPY selenium_setup.sh .

RUN bash apt_additions.sh
RUN bash python_additions.sh
RUN Rscript R_additions.R
RUN bash selenium_setup.sh

RUN PATH=$PATH:/usr/local/bin
RUN R -e "IRkernel::installspec(user = FALSE)"

# SET UP NGINX
EXPOSE 80
EXPOSE 443
RUN apt-get update && \
    apt-get install nginx -y && \
    apt-get clean

# COPY IN NGINX TEMPLATES
ENV VIRTUAL_PATH=/
COPY nginx.conf /
COPY default /

# MOVE TEMPLATES TO CORRECT PLACE
RUN mv nginx.conf /etc/nginx/nginx.conf
RUN mv default /etc/nginx/sites-available/default

# BUILD STARTUP SCRIPT
COPY run.sh /
RUN chmod +x /run.sh
