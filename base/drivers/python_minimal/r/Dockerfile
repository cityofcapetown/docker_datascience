FROM cityofcapetown/datascience:python_minimal 

LABEL authors="Riaz Arbi"
ARG DEBIAN_FRONTEND=noninteractive


# BASE ==========================================
# Set locales and install make
RUN apt-get clean && \
    apt-get update && \
    apt-get install -y \
    locales locales-all tzdata

ENV TZ="Africa/Johannesburg"
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV TERM xterm

# Copy in needed files
COPY apt.txt .
COPY install.R .

# Do the build in one layer to keep the image as small as possible.
# temporary symlink to fix broken apt_inst and apt_pkg for gdebi and add-apt-repository
# remove when the python 3.9 dependencies are removed from python_minimal
RUN  ln -s /usr/lib/python3/dist-packages/apt_pkg.cpython-310-x86_64-linux-gnu.so /usr/lib/python3/dist-packages/apt_pkg.so \
  && ln -s /usr/lib/python3/dist-packages/apt_inst.cpython-310-x86_64-linux-gnu.so /usr/lib/python3/dist-packages/apt_inst.so \
# Install common utils
  && apt-get install -y --no-install-recommends \
    make \
    git \
# Install R
&& apt-get install -y --no-install-recommends \
    software-properties-common \
    dirmngr \
    curl \
    wget \
    gpg \
    gcc \
    build-essential \
 && wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc \
 && sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/" \
 && apt-get update \
 && apt-get install -y --no-install-recommends r-base \
# Install system dependencies for common R packages
# First install known minimal system dependencies
 && echo "Checking for 'apt.txt'..." \
        ; if test -f "apt.txt" ; then \
        apt-get update --fix-missing > /dev/null\
        && xargs -a apt.txt apt-get install --yes \
        && apt-get clean > /dev/null \
        && rm -rf /var/lib/apt/lists/* \
        && rm -rf /tmp/* \
        ; fi \
# Makes use of pak to install system dependencies of CRAN top 100 packages as well
# Use install.R to determine what apt packages are needed...
    && if [ -f install.R ]; then R --quiet -f install.R; fi \
# ...install.R will create a bash install file called R_apt_deps.txt...
# ...and then use apt to install those packages
 && echo "Checking for 'R_apt_deps.'..." \
        ; if test -f "R_apt_deps.sh" ; then \
        /bin/bash R_apt_deps.sh \
        && apt-get clean > /dev/null \
        && rm -rf /var/lib/apt/lists/* \
        && rm -rf /tmp/* \
        ; fi


# Enable prompt color in the skeleton .bashrc before creating the default NB_USER
RUN sed -i 's/^#force_color_prompt=yes/force_color_prompt=yes/' /etc/skel/.bashrc

# Create $NB_USER
ENV NB_USER=rovyan
ENV NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
    
# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}
WORKDIR ${HOME}
