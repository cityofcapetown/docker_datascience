# This installs packages that are not present in the base R docker image
# Will be added to with time

# CRAN packages go here:
list.of.packages <- c("caTools",
                      "shinythemes",
                      "shinyBS",
                      "shinyLP",
                      "keras",
                      "xlsx",
                      "Quandl",
                      "network",
                      "sna",
                      "visNetwork",
                      "threejs",
                      "networkD3",
                      "ndtv",
                      "leaflet",
                      "factoextra",
                      "arules",
                      "DiagrammeRsvg", "DiagrammeRsvg",
                      "arulesViz", "kohonen", "dummies", "tempR", "WDI",
                      "smacof", "cluster", "ggmap", "googleway", "RJSONIO",
                      "bupaR", "edeaR", "eventdataR", "processmapR",
                      "processmonitR", "xesreadR", "petrinetR",
                      "prophet", "timevis", "kableExtra",
                      "IRdisplay", "evaluate", "crayon", "pbdZMQ",
                      "esquisse", "flexdashboard", "shinydashboard", "reticulate",
                     "lwgeom", "doParallel", "rasterVis", "viridis", "ggExtra")

new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]

options(Ncpus = 4)
if(length(new.packages)) install.packages(new.packages)

# Non-standard packages go here
# INSTALL H3FORR
devtools::install_github("cityofcapetown/h3forr")

# INSTALL TINYTEX
library(devtools)
library(tinytex)
tinytex::install_tinytex(force=TRUE)

# INSTALL XARINGAN
devtools::install_github('yihui/xaringan')
install.packages("webshot")
library(webshot)
install_phantomjs()

# INSTALL DYGRAPHS
devtools::install_github(c("ramnathv/htmlwidgets", "rstudio/dygraphs"))

# INSTALL KERAS
devtools::install_github("rstudio/keras")
library(keras)
keras::install_keras()

#INSTALL H2O
if ("package:h2o" %in% search()) { detach("package:h2o", unload=TRUE) }
if ("h2o" %in% rownames(installed.packages())) { remove.packages("h2o") }
# Install dependencies if not already installed
pkgs <- c("RCurl","jsonlite")
for (pkg in pkgs) {
  if (! (pkg %in% rownames(installed.packages()))) { install.packages(pkg) }
}
# Now we download and install h2o and R h2o package. 
install.packages("h2o", type="source", repos=(c("http://h2o-release.s3.amazonaws.com/h2o/latest_stable_R")))


