#!/usr/bin/env bash

# First, we pull in everything from the Python image
source /python_additions.sh

# GPU python specific packages
python3 -m pip install pyopencl==2016.1 # CUDA only provides OpenCL bindings up to 1.2