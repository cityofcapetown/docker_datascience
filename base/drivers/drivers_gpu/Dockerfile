FROM cityofcapetown/datascience:drivers

LABEL authors="Riaz Arbi,Gordon Inggs"

# CUDA
# Special args for nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

COPY cuda_setup.sh .
RUN bash cuda_setup.sh

# OpenCL
# POCL
RUN DEBIAN_FRONTEND=noninteractive \
  apt-get update && \
  apt-get install -y pocl-opencl-icd opencl-headers clinfo

# Nvidia ICD
RUN DEBIAN_FRONTEND=noninteractive \
  apt-get update && \
  apt-get install -y nvidia-opencl-icd-340 nvidia-opencl-dev