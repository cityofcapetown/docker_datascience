# Non-standard packages go here

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
# The following two commands remove any previously installed H2O packages for R.
if ("package:h2o" %in% search()) { detach("package:h2o", unload=TRUE) }
if ("h2o" %in% rownames(installed.packages())) { remove.packages("h2o") }
# Now we download and install h2o runtime and R h2o package.
install.packages("h2o", type="source",
repos="http://h2o-release.s3.amazonaws.com/h2o/rel-wolpert/8/R")

