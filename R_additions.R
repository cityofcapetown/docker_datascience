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
                      "quandl",
                     "igraph",
                     "network",
                     "sna",
                     "visNetwork",
                     "threejs",
                     "networkD3",
                     "ndtv",
                     "bupaR)

new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]

if(length(new.packages)) install.packages(new.packages)

# Non-standard packages go here

# INSTALL TINYTEX
library(tinytex)
tinytex::install_tinytex()

# INSTALL KERAS
#library(devtools)
#devtools::install_github("rstudio/keras")
library(keras)
install_keras()

#INSTALL H2O
# The following two commands remove any previously installed H2O packages for R.
if ("package:h2o" %in% search()) { detach("package:h2o", unload=TRUE) }
if ("h2o" %in% rownames(installed.packages())) { remove.packages("h2o") }
# Next, we download packages that H2O depends on.
pkgs <- c("RCurl","jsonlite")
for (pkg in pkgs) {
  if (! (pkg %in% rownames(installed.packages()))) { install.packages(pkg) }
}
# Now we download and install h2o runtime and R h2o package.
install.packages("h2o", type="source", 
repos="http://h2o-release.s3.amazonaws.com/h2o/rel-wolpert/8/R")
