FROM cityofcapetown/datascience:base

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
COPY oracle-instantclient-basic-21.4.0.0.0-1.el8.x86_64.rpm /
COPY oracle-instantclient-odbc-21.4.0.0.0-1.el8.x86_64.rpm /
RUN alien -i /oracle-instantclient-basic-21.4.0.0.0-1.el8.x86_64.rpm && \
    alien -i /oracle-instantclient-odbc-21.4.0.0.0-1.el8.x86_64.rpm
RUN rm /oracle-instantclient-basic-21.4.0.0.0-1.el8.x86_64.rpm && \
    rm /oracle-instantclient-odbc-21.4.0.0.0-1.el8.x86_64.rpm

ENV LD_LIBRARY_PATH /usr/lib/oracle/21/client64/lib/${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}
RUN ldconfig

RUN echo "[Oracle Driver 21.4]\nDescription=Oracle Unicode driver\nDriver=/usr/lib/oracle/21/client64/lib/libsqora.so.21.1\nUsageCount=1\nFileUsage=1" \
  >> /etc/odbcinst.ini

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
