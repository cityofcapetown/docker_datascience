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
enchant

# INSTALL JAVA
# Oracle PPA doesnt work so we are using OpenJDK

DEBIAN_FRONTEND=noninteractive \
apt-get update && \
apt-get install -y \
default-jre \
default-jdk && \
apt-get clean
