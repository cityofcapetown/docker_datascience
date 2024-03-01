# City of Cape Town's Datascience Docker Images

This repository contains cascading image tags used for Datascience at the City of Cape Town by the Data Science branch.

## Overview

The current structure of these image tags (and the repo):
```
└── base
    └── drivers
        ├── python_minimal
        ├── jupyter-ide
        ├── python
        │   └── jupyter-k8s
        └── r_minimal
            └── r
                └── rstudio
```

Overview of the tags:
* `base` - based on `Ubuntu 22.04`. Contains various CLI utilities such as vim, htop, etc.
* `drivers` - Installs various drivers, include ODBC as well as Selenium.
* `python_minimal` - Installs Python 3 and a limited selection of python packages (see 
  [here](./base/drivers/python_minimal/python_additions.sh)).
* `python` - Installs many Python packages (see [here](./base/drivers/python_minimal/python/python_additions.sh)).
* `jupyter-k8s` - Installs and runs Jupyterlab on top of `python`
* `r_minimal` - (coming soon) Installs R and a limited section of packages. On top of `python_minimal`.
* `r` - (coming soon) Installs many R packages
* `rstudio` - (coming soon) Install and runs RStudio via rsession proxy on top of `r`.
* `jupyter-ide` - Makes various IDEs (PyCharm, VSCode) available on top of `python_minimal`.

## Usage
These images are intented to be used either as part of a Jupyterhub setup, or as the base for airflow Kubernetes 
operator jobs. 

To enter an image and poke around (useful for checking whether a dependency is statisfied), use the `docker exec` 
or `kubectl exec` command to start a bash shell, e.g.

```bash
docker exec -it -rm cityofcapetown/datascience:python bash
```