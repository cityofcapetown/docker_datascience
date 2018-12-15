#!/usr/bin/env bash

# These are packages used in both Python and R.
DEBIAN_FRONTEND=noninteractive \
  apt-get clean && \
  apt-get update && \
  apt-get install -y \
  python3 \
  python3-pip

# JAVA
# Oracle PPA doesnt work so we are using OpenJDK
DEBIAN_FRONTEND=noninteractive \
  apt-get install -y \
  default-jre \
  default-jdk && \
  apt-get clean

# ODBC
# More specifically, the Microsoft driver
DEBIAN_FRONTEND=noninteractive \
  apt-get install -y gnupg2

DEBIAN_FRONTEND=noninteractive \
  wget https://packages.microsoft.com/keys/microsoft.asc -O microsoft.asc && \
  apt-key add microsoft.asc && \
  wget https://packages.microsoft.com/config/ubuntu/18.04/prod.list -O prod.list && \
  cp prod.list /etc/apt/sources.list.d/mssql-release.list && \
  apt-get update && \
  ACCEPT_EULA=Y apt-get install -y \
  msodbcsql17 \
  unixodbc-dev
