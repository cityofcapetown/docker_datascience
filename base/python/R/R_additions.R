# This installs packages that are not present in the base docker image
# Will be added to with time

# CRAN packages go here:
list.of.packages <- c("evaluate",
                      "highr",
                      "markdown",
                      "htmltools",
                      "caTools",
                      "knitr",
                      "rprojroot",
                      "rmarkdown",
                      "bookdown",
                      "tinytex",
                      "caTools",
                      "ggplot2", 
                      "Rcpp",
                      "tidyverse",
                      "gridExtra",
                      "devtools",
                      "markdown", 
                      "shinythemes", 
                      "shinyBS", 
                      "shinyLP",
                      "keras",
                      "xlsx",
                      "Quandl",
                      "igraph",
                      "network",
                      "sna",
                      "visNetwork",
                      "threejs",
                      "networkD3",
                      "ndtv",
                      "leaflet",
                      "RCurl",
                      "jsonlite",
                      "factoextra",
                      "arules",
                      "DiagrammeRsvg", "DiagrammeRsvg",
                      "arulesViz", "kohonen", "dummies", "tempR", "WDI", 
                      "smacof", "cluster", "ggmap", "googleway", "RJSONIO",
                      "geojsonio", "bupaR", "edeaR", "eventdataR", "processmapR",
                     "processmonitR", "xesreadR", "petrinetR",
                     "prophet", "timevis", "kableExtra",
                     "repr", "IRdisplay", "evaluate", "crayon", "pbdZMQ", "devtools", "uuid", "digest",
                     "esquisse", "flexdashboard", "shinydashboard", "reticulate", "feather")

new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]

options(Ncpus = 4)
if(length(new.packages)) install.packages(new.packages)
