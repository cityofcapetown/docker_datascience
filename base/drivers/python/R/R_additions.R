# This installs packages that are not present in the base docker image
# Will be added to with time

# CRAN packages go here:
list.of.packages <- c("evaluate",
                      "highr",
                      "markdown",
                      "htmltools",
                      "knitr",
                      "Rcpp",
                      "rprojroot",
                      "rmarkdown",
                      "bookdown",
                      "tinytex",
                      "ggplot2",
                      "tidyverse",
                      "gridExtra",
                      "fasterize",
                      "devtools",
                      "markdown",
                      "xlsx",
                      "igraph",
                      "RCurl",
                      "jsonlite",
                      "RJSONIO",
                      "geojsonio",
                      "repr", 
                      "IRdisplay", 
                      "crayon", 
                      "uuid", 
                      "digest",
                      "feather",
                      "tidyquant")

new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]

options(Ncpus = 4)
if(length(new.packages)) install.packages(new.packages)
