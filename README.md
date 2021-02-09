# City of Cape Town's Datascience Docker Images

This repository contains cascading image tags used for Datascience at the City of Cape Town by the Organisational 
Performance Management branch.

## Overview

The current structure of these image tags (and the repo):
```
.
└── base
    └── drivers
        └── python_minimal
            └── python
                └── jupyter-k8s
                    └── rsession

```

Overview of the tags:
* `base` - based on `Ubuntu 18.04`. Contains various utilities, a NGINX reverse proxy and a run script.
* `drivers` - Installs various drivers, include ODBC as well as Selenium.
* `python_minimal` - Installs Python3 and a limited selection of python packages (see 
  [here](./base/drivers/python_minimal/python_additions.sh)).
* `python` - Installs many Python packages (see [here](./base/drivers/python_minimal/python/python_additions.sh)).
* `jupyter-k8s` - Installs and runs Jupyterlab on top of `python`
* `rsession` - TBC

## Usage
These images are intented to be used either as part of a Jupyterhub setup, or as the base for airflow jobs. 

To enter an image and poke around (useful for checking whether a dependency is statisfied), use the `docker exec` 
command to start a bash shell, e.g.
```bash
docker exec -it -rm cityofcapetown/datascience:python bash
```