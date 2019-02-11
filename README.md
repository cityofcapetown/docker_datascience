# City of Cape Town's Datascience Docker Images

This repository contains cascading images used for Datascience at the City of Cape Town by the Organisational 
Performance Management branch.

## Overview

The current structure of these images (and the repo):
```
.
└── base
    └── drivers
        ├── drivers_gpu
        │   └── python_gpu
        │       └── jupyter_gpu
        └── python
            ├── jupyter
            └── R
                └── R_nonstandard
                    └── rstudio_shiny
```

Overview of the images:
* `base` - based on `Ubuntu 18.04`. Contains various utilities, a NGINX reverse proxy and a run script.
* `drivers` - Installs various drivers, include ODBC as well as Selenium.
* `drivers_gpu` - Installs CUDA and OpenCL libraries for interacting with the NVIDIA container runtime.
* `python` - Installs Python3 and many Python packages (see `./base/python/python_additions.sh`).
* `python_gpu` - Identical to the python image, but descending from `drivers_gpu`.
* `jupyter` - Installs and runs Jupyterlab + Jupyterhub.
* `jupyter_gpu` - Identical to the `jupyter` image, but descending from `python_gpu`.
* `R` and `R_nonstandard` - Installs R, and many R packages, including `MixTex` and `h2o`  (see `./base/python/R/R_additions.R` and `./base/python/R/R_nonstandard/R_nonstandard.R`).
* `rstudio_shiny` - Installs and runs rstudio and shiny server.

## Usage
### Starting Docker Images
* The default user does not have sudo privileges. These can be enabled by setting `SUDO=yes`.
* The default username is `newuser` and the password is `password`. To change the defaults, change the environment 
variables `$NEWUSER` and `$PASSWD`.
* You can clone a git repository into the `$NEWUSER` home directory by specifying the url with `$GIREPO`. If you don't 
specify a directory, it will not clone in anything.
* By default the image exposes and listens on port `80`. This can be overridden using Docker's `-p` flags, i.e. 
`-p <desired port>:80`.
* The NGINX proxy by default binds to `localhost` and assumes that it is serving up at `/`. This can be overridden using 
the `$VIRTUAL_HOST` and `$VIRTUAL_PATH` variables. This is useful if the image is being served up from behind a reverse proxy.

So a command that uses all the options and starts up jupyterhub:
```
docker run -it --rm \
-e NEWUSER=neweruser \
-e PASSWD=newpassword \
-e SUDO=yes \
-e GITREPO=https://github.com/riazarbi/workspace_template.git \
-p 8000:80 \
-e VIRTUAL_HOST=127.0.0.1 \
-e VIRTUAL_PATH=/ \
cityofcapetown/docker_datascience:jupyter
```

### Interacting with services
NGINX is used to proxy to various services within the Docker image:

* Jupyterlab can be found at `http://localhost/jupyter/` (**NB** the trailing slash) when running the `jupyter` image.
* RStudio can be found at `http://localhost/rstudio/` (**NB** the trailing slash) when running the `rstudio_shiny` image.
* Shiny can be found at `http://localhost/shiny/` (**NB** the trailing slash) when running the `rstudio_shiny` image.

**NB** The above assumes that the default `$VIRTUAL_HOST`, `$VIRTUAL_PATH` and port values are being used.

### Recommended
* If you're working in the City of Cape Town's data science environment, it's recommended to use the `/etc/hosts` from the
host machine, i.e. mount the hosts file within the container `-v /etc/hosts:/etc/hosts:ro`.