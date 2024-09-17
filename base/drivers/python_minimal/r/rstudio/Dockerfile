FROM cityofcapetown/datascience:r

USER root

# Install system dependencies ==================================================
# BOTH JUPYTER AND RSTUDIO DEPS ================================================
RUN apt-get update --fix-missing > /dev/null \
 && apt-get install --yes --no-install-recommends \
    # for jupyter
    git \
    sudo \
    libzmq3-dev \
    wget \
    bzip2 \
    ca-certificates \
    sudo \
    locales \
    fonts-liberation \
    nodejs \
    npm \
    # for Rstudio
    pkg-config \
    file \
    gdebi-core \
    psmisc \
    libclang-dev \
    libpq5 \
    libssl-dev \
 && apt-get clean > /dev/null \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /tmp/* \
 # Install Jupyter ==============================================================
 && python3 -m pip install "charset-normalizer" \
 && python3 -m pip install jsonschema[format-nongpl] \
 && python3 -m pip install --no-cache-dir notebook jupyterlab \
 && python3 -m pip install --no-cache-dir jupyter-rsession-proxy jupyterhub \
 && Rscript -e 'remotes::install_github("IRkernel/IRkernel@*release")' \
 && Rscript -e 'IRkernel::installspec(user = FALSE)' \
 # Install Rstudio
 && wget --quiet https://download2.rstudio.org/server/jammy/amd64/rstudio-server-2024.04.2-764-amd64.deb  \
 && gdebi -n rstudio-server-2024.04.2-764-amd64.deb \
# Clean up
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /tmp/downloaded_packages \
 && rm -rf rstudio-server-2024.04.2-764-amd64.deb \
# Install VSCode
 && curl -fsSL https://code-server.dev/install.sh | sh \
 && pip3 install jupyter-vscode-proxy 

# Back to non privileged user
# These env vars are in FROM image
ENV NB_USER=rovyan
ENV NB_UID=1000
ENV NB_GID=100
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}
RUN chown -R ${NB_USER} ${HOME}


# USER SETTINGS ============================================================

USER ${NB_USER}
WORKDIR ${HOME}

# Install VSCode extensions
RUN code-server --install-extension ms-python.python \
 && code-server --install-extension innoverio.vscode-dbt-power-user \
 && code-server --install-extension REditorSupport.r

# Set NB_USER ENV vars
ENV PATH="${PATH}:/usr/lib/rstudio-server/bin" 
ENV TZ="Africa/Johannesburg"

# Clean npm cache, create a new jupyter notebook config
RUN npm cache clean --force  \
 && jupyter notebook --generate-config  \
 && rm -rf /home/$NB_USER/.cache/yarn 

# Configure container startup
CMD ["/bin/bash", "start-notebook.sh"]

# Image launch scripts
COPY start.sh /usr/local/bin/
COPY start-notebook.sh /usr/local/bin/
COPY start-singleuser.sh /usr/local/bin/
COPY jupyter_notebook_config.py /etc/jupyter/

# ROOT USER CLEANUP =========================================================

# Fix permissions on /etc/jupyter as root
USER root

# Add a script that we will use to correct permissions after running certain commands
ADD fix-permissions /usr/local/bin/fix-permissions  
RUN chmod +x /usr/local/bin/fix-permissions 

RUN /usr/local/bin/fix-permissions /etc/jupyter/
RUN /usr/local/bin/fix-permissions $HOME 

# Run as NB_USER ============================================================

USER $NB_USER

