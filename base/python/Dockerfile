FROM cityofcapetown/datascience:base

LABEL authors="Riaz Arbi,Gordon Inggs"

COPY apt.sh .
COPY python_additions.sh .
COPY selenium_setup.sh .

RUN bash apt.sh
RUN bash python_additions.sh
RUN bash selenium_setup.sh

# ODBC
EXPOSE 1433
