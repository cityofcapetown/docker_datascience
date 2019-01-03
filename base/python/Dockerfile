FROM cityofcapetown/datascience:base

LABEL authors="Riaz Arbi,Gordon Inggs"

# These are packages used in both Python and R.
RUN DEBIAN_FRONTEND=noninteractive \
  apt-get clean && \
  apt-get update && \
  apt-get install -y \
  python3 \
  python3-pip

# JAVA
# OpenJDK
RUN DEBIAN_FRONTEND=noninteractive \
  apt-get install -y \
  default-jre \
  default-jdk && \
  apt-get clean

# ODBC
RUN DEBIAN_FRONTEND=noninteractive \
  apt-get update && \
  apt-get install -y gnupg2 unixodbc-dev

# Microsoft driver
RUN wget https://packages.microsoft.com/keys/microsoft.asc -O microsoft.asc && \
  apt-key add microsoft.asc && \
  wget https://packages.microsoft.com/config/ubuntu/18.04/prod.list -O prod.list && \
  cp prod.list /etc/apt/sources.list.d/mssql-release.list && \
  apt-get update && \
  ACCEPT_EULA=Y apt-get install -y \
  msodbcsql17

# Python dependencies
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
    enchant enchant-dev \
    libfreetype6-dev \
    pkg-config \
    libpng12-dev

COPY python_additions.sh .
COPY selenium_setup.sh .

RUN bash python_additions.sh
RUN bash selenium_setup.sh

# ODBC
EXPOSE 1433
