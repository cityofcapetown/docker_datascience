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

if(length(new.packages)) install.packages(new.packages)

# Non-standard packages go here

# INSTALL TINYTEX
library(tinytex)
tinytex::install_tinytex(force=TRUE)

# INSTALL R KERNEL
devtools::install_github('IRkernel/IRkernel')
#IRKernel:installspec(user = FALSE)

# INSTALL XARINGAN
devtools::install_github('yihui/xaringan')
install.packages("webshot")
library(webshot)
install_phantomjs()

# INSTALL DYGRAPHS
devtools::install_github(c("ramnathv/htmlwidgets", "rstudio/dygraphs"))

# INSTALL KERAS
#library(devtools)
#devtools::install_github("rstudio/keras")
library(keras)
keras::install_keras()

#INSTALL H2O
# The following two commands remove any previously installed H2O packages for R.
if ("package:h2o" %in% search()) { detach("package:h2o", unload=TRUE) }
if ("h2o" %in% rownames(installed.packages())) { remove.packages("h2o") }
# Now we download and install h2o runtime and R h2o package.
install.packages("h2o", type="source", 
repos="http://h2o-release.s3.amazonaws.com/h2o/rel-wolpert/8/R")
