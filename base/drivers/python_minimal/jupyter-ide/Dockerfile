FROM cityofcapetown/datascience:python_minimal

LABEL authors="Gordon Inggs"

# Create same user as jupyter docker stacks so that k8s will run fine
ARG NB_USER="jovyan"
ARG NB_UID="1000"
ARG NB_GID="100"

USER root

# Setting up nodejs source list
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash -

# Install base packages
ENV DEBIAN_FRONTEND noninteractive
ENV ACCEPT_EULA Y
RUN apt-get update && \
    apt-get -yq dist-upgrade && \
    apt-get install -yq --no-install-recommends \
    wget \
    bzip2 \
    ca-certificates \
    sudo \
    locales \
    fonts-liberation \
    nodejs \
 && rm -rf /var/lib/apt/lists/*

# Install all the jupyter packages
RUN python3 -m pip install --upgrade pip && \
    python3 -m pip install jupyter jupyterhub jupyterlab jupyter_core

# VS Code
# VS Code iteself
# credit to https://github.com/riazarbi/makeR/blob/main/binder/Dockerfile#L48-L49
RUN curl -fsSL https://code-server.dev/install.sh | sh && \
    pip3 install jupyter-vscode-proxy

# VS Code extensions
RUN code-server --install-extension ms-python.python && \
    code-server --install-extension REditorSupport.r

# PyCharm
# mostly looking at https://github.com/tiaden/jupyter-projector-proxy
# PyCharm Dependencies
RUN apt-get update && \
  apt-get install -y \
  libxtst6 \
  libxrender1 \
  libfontconfig1 \
  libxi6 \
  libgtk-3-0

# PyCharm itself
ADD install-pycharm.sh /usr/local/bin/install-pycharm.sh
RUN chmod +x /usr/local/bin/install-pycharm.sh
RUN install-pycharm.sh $NB_UID $NB_GID

# Webstorm
ADD install-webstorm.sh /usr/local/bin/install-webstorm.sh
RUN chmod +x /usr/local/bin/install-webstorm.sh
RUN install-webstorm.sh $NB_UID $NB_GID

# PyCharm jupyter packages
RUN python3 -m pip install jupyter-projector-proxy jupyter-server-proxy projector_installer

# Back to jupyter setup
# Sort out locales
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

# Configure environment
ENV SHELL=/bin/bash \
    NB_USER=$NB_USER \
    NB_UID=$NB_UID \
    NB_GID=$NB_GID \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8
ENV HOME=/home/$NB_USER

# Add a script that we will use to correct permissions after running certain commands
ADD fix-permissions /usr/local/bin/fix-permissions
RUN chmod +x /usr/local/bin/fix-permissions

# Enable prompt color in the skeleton .bashrc before creating the default NB_USER
RUN sed -i 's/^#force_color_prompt=yes/force_color_prompt=yes/' /etc/skel/.bashrc

# Create NB_USER with name jovyan user with UID=1000 and in the 'users' group
# and make sure these dirs are writable by the `users` group.
RUN echo "auth requisite pam_deny.so" >> /etc/pam.d/su && \
    sed -i.bak -e 's/^%admin/#%admin/' /etc/sudoers && \
    sed -i.bak -e 's/^%sudo/#%sudo/' /etc/sudoers && \
    useradd -m -s /bin/bash -N -u $NB_UID $NB_USER && \
    chmod g+w /etc/passwd
RUN /usr/local/bin/fix-permissions $HOME

USER $NB_UID
WORKDIR $HOME

# Clean npm cache, create a new jupyter notebook config
RUN npm cache clean --force && \
    jupyter notebook --generate-config && \
    rm -rf /home/$NB_USER/.cache/yarn && \
    fix-permissions /home/$NB_USER

# Expose the right port
EXPOSE 8888

# Configure container startup
CMD ["/bin/bash", "start-notebook.sh"]

# Add local files as late as possible to avoid cache busting
COPY start.sh /usr/local/bin/
COPY start-notebook.sh /usr/local/bin/
COPY start-singleuser.sh /usr/local/bin/
COPY jupyter_notebook_config.py /etc/jupyter/

# Fix permissions on /etc/jupyter as root
USER root
RUN fix-permissions /etc/jupyter/

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_UID

RUN pip3 install projector-installer --user
