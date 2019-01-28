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
  apt-get install -y gnupg2 unixodbc-dev unixodbc-bin unixodbc libaio1 alien

# Microsoft driver
RUN wget https://packages.microsoft.com/keys/microsoft.asc -O microsoft.asc && \
  apt-key add microsoft.asc && \
  wget https://packages.microsoft.com/config/ubuntu/18.04/prod.list -O prod.list && \
  cp prod.list /etc/apt/sources.list.d/mssql-release.list && \
  apt-get update && \
  ACCEPT_EULA=Y apt-get install -y \
  msodbcsql17

# Oracle driver
COPY oracle-instantclient18.3-basic-18.3.0.0.0-1.x86_64.rpm /
COPY oracle-instantclient18.3-odbc-18.3.0.0.0-1.x86_64.rpm /
RUN alien -i /oracle-instantclient18.3-basic-18.3.0.0.0-1.x86_64.rpm && \
    alien -i /oracle-instantclient18.3-odbc-18.3.0.0.0-1.x86_64.rpm
RUN rm /oracle-instantclient18.3-basic-18.3.0.0.0-1.x86_64.rpm && \
    rm /oracle-instantclient18.3-odbc-18.3.0.0.0-1.x86_64.rpm

ENV LD_LIBRARY_PATH /usr/lib/oracle/18.3/client64/lib/${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}
RUN ldconfig

RUN echo "[Oracle Driver 18.3]\nDescription=Oracle Unicode driver\nDriver=/usr/lib/oracle/18.3/client64/lib/libsqora.so.18.1\nUsageCount=1\nFileUsage=1" \
  >> /etc/odbcinst.ini

# Python dependencies
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update && \
    apt-get install -y \
    enchant libenchant-dev \
    libfreetype6-dev \
    pkg-config \
    libpng-dev

COPY python_additions.sh .
COPY selenium_setup.sh .

RUN bash python_additions.sh
RUN bash selenium_setup.sh

# ODBC
EXPOSE 1433
