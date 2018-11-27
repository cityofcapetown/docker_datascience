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

# Install Selenium Web Drivers
# Firefox driver
wget https://github.com/mozilla/geckodriver/releases/download/v0.21.0/geckodriver-v0.21.0-linux64.tar.gz -O geckodriver.tar.gz
tar -xzf geckodriver.tar.gz
rm -rf geckodriver.tar.xz
mv geckodriver /usr/bin/geckodriver

# Headless X environment
apt-get update && \
apt install -y chromium-browser \
               xvfb \
               firefox \
               libdbus-glib-1-2 \
               libgtk2.0-0 \
               libasound2

# Latex (Mostly for generating PDFs)
apt install -y texlive-latex-base \
	       texlive-fonts-recommended \
	       texlive-fonts-extra \
	       texlive-latex-extra
