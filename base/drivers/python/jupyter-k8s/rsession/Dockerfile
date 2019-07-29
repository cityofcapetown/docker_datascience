FROM jupyter-k8s

USER root

RUN apt-get update && \
	apt-get install -y --no-install-recommends \
		libapparmor1 \
		libedit2 \
		lsb-release \
		psmisc \
		libssl1.0.0 

# R pre-requisites
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-dejavu \
    unixodbc \
    unixodbc-dev \
    gfortran gnupg \
    gcc libclang-dev psmisc libapparmor1 lsb-release && \
    rm -rf /var/lib/apt/lists/*

RUN gpg --keyserver keyserver.ubuntu.com --recv-key E298A3A825C0D65DFD57CBB651716619E084DAB9
RUN gpg -a --export E298A3A825C0D65DFD57CBB651716619E084DAB9 | sudo apt-key add -

#RUN add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/'
RUN echo deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/ >> /etc/apt/sources.list
RUN cat /etc/apt/sources.list

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    r-base-dev gdebi-core && \
    rm -rf /var/lib/apt/lists/*


# ENV RSTUDIO_VERSION 1.1.456
ENV RSTUDIO_VERSION 1.2.1335

# RUN wget --quiet https://download2.rstudio.org/rstudio-server-${RSTUDIO_VERSION}-amd64.deb
RUN wget --quiet https://download2.rstudio.org/server/bionic/amd64/rstudio-server-${RSTUDIO_VERSION}-amd64.deb
RUN gdebi -n rstudio-server-${RSTUDIO_VERSION}-amd64.deb
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

#USER $NB_USER

RUN pip install git+https://github.com/jupyterhub/jupyter-server-proxy
# RUN pip install git+https://github.com/ryanlovett/jupyter-server-proxy@configurable_headers
RUN pip install git+https://github.com/jupyterhub/jupyter-rsession-proxy

USER $NB_USER
ENV PATH="${PATH}:/usr/lib/rstudio-server/bin"
