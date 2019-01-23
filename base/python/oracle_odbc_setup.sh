#!/usr/bin/env bash

EDGE_LOCATION="ds2.capetown.gov.za"
ORACLE_BUCKET_NAME="oracle-instantclient"
INSTANCE_CLIENT="oracle-instantclient18.3-basic-18.3.0.0.0-1.x86_64"
ODBC_DRIVER="oracle-instantclient18.3-odbc-18.3.0.0.0-1.x86_64"

# Detecting whether we can get to the Minio Edge
nslookup $EDGE_LOCATION

if [ $? -eq 0 ]; then
    # Getting Oracle client and ODBC driver
    wget -q https://"$EDGE_LOCATION"/"$ORACLE_BUCKET_NAME"/"$INSTANCE_CLIENT".rpm --directory-prefix /tmp/
    wget -q https://"$EDGE_LOCATION"/"$ORACLE_BUCKET_NAME"/"$ODBC_DRIVER".rpm --directory-prefix /tmp/

    # Converting and installing the Oracle client
    alien -i /tmp/"$INSTANCE_CLIENT".rpm
    alien -i /tmp/"$ODBC_DRIVER".rpm

    # Removing the RPM files
    rm /tmp/"$INSTANCE_CLIENT".rpm
    rm /tmp/"$ODBC_DRIVER".rpm

    # Updating the environmental config
    export LD_LIBRARY_PATH=/usr/lib/oracle/18.3/client64/lib/${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}
    ldconfig

    # Updating the ODBC config file
    echo -e "[Oracle Driver 18.3]\nDescription=Oracle Unicode driver\nDriver=/usr/lib/oracle/18.3/client64/lib/libsqora.so.18.1\nUsageCount=1\nFileUsage=1" \
      >> /etc/odbcinst.ini

else
    echo "Could not resolve ds2.capetown.gov.za, not installing Oracle client"
fi