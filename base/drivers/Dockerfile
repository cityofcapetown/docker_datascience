FROM cityofcapetown/datascience_base

LABEL authors="Riaz Arbi,Gordon Inggs"

# JAVA
# OpenJDK
RUN DEBIAN_FRONTEND=noninteractive \
  apt-get update && \
  apt-get install -y \
  default-jre \
  default-jdk && \
  apt-get clean

COPY selenium_setup.sh .
RUN bash selenium_setup.sh

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

# ODBC
EXPOSE 1433

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
