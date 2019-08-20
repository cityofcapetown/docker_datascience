FROM cityofcapetown/datascience:R-8020

LABEL authors="Riaz Arbi,Gordon Inggs"

USER root

# BASE BACKAGES =============================================================
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    cmake \
    make \
    gcc \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* 

# RPACKAGES =================================================================

ARG r_packages="\
# inspect code performance
    profvis \ 
# hash tables
    hashmap \  
# Interactive maps
    leaflet \
# Geoprocessing
    fasterize \
# Plotting extras
    ggExtra \ 
# Process mining
    bupaR \
    edeaR \ 
    eventdataR \  
    processmapR \
    processmonitR \ 
# Parallel processing
    doParallel \
#    evaluate \
#    highr \
#    markdown \
#    htmltools \
#    knitr \
#    rprojroot \
#    rmarkdown \
#    bookdown \
#    tinytex \
#    gridExtra \
#    markdown \
#    igraph \
#    RCurl \
#    jsonlite \
#    RJSONIO \
#    geojsonio \
#    repr \
#    IRdisplay \ 
#    crayon \ 
#    uuid \
#    digest \
#    caTools \
#    shinythemes \
#    shinyBS \
#    shinyLP \
#    keras \
#    xlsx \
#    network \
#    sna \
#    visNetwork \
#    threejs \
#    networkD3 \
#    ndtv \
#    factoextra \
#    arules \
#    DiagrammeRsvg \
#    arulesViz \
#    kohonen \
#    dummies \ 
#    tempR \
#    WDI \
#    smacof \ 
#    cluster \ 
#    ggmap \
#    googleway \ 
#    RJSONIO \
#    xesreadR \
#    petrinetR \
#    prophet \
#    timevis \ 
#    kableExtra \
#    IRdisplay \
#    evaluate \
#    crayon \
#    pbdZMQ \
#    esquisse \
#    flexdashboard \
#    shinydashboard \ 
#    lwgeom \
#    rasterVis \
#    viridis \
#    caret \
#    drake \ 
#    RSQLite \
#    writexl \ 
#    odbc \
    "

# Install
RUN install2.r --error -n 2 -s --deps TRUE $r_packages 

USER $NB_USER
