# These are apt packages required to make R
# and python packages work
DEBIAN_FRONTEND=noninteractive \
apt-get clean && \
apt-get update && \
apt-get install -y  \
libxml2-dev \
bash \
software-properties-common \
libssh2-1-dev \
zlib1g-dev \
libxml2-dev \
libssl-dev \
ibpython2.7 \
python-pip \
python-virtualenv \
enchant \
libprotobuf-dev \
libv8-3.14-dev \
libjq-dev \
libudunits2-dev \
protobuf-compiler \
libgdal-dev


# INSTALL JAVA
# Oracle PPA doesnt work so we are using OpenJDK

DEBIAN_FRONTEND=noninteractive \
apt-get update && \
apt-get install -y \
default-jre \
default-jdk && \
apt-get clean

# INSTALL ODBC
# More specifically, the Microsoft driver

DEBIAN_FRONTEND=noninteractive \
wget https://packages.microsoft.com/keys/microsoft.asc -O microsoft.asc && \
apt-key add microsoft.asc && \
wget https://packages.microsoft.com/config/ubuntu/18.04/prod.list -O prod.list && \
cp prod.list /etc/apt/sources.list.d/mssql-release.list && \
apt-get update && \
ACCEPT_EULA=Y apt-get install -y \
msodbcsql17 \
unixodbc-dev
