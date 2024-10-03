# Base packages
install.packages(c("pak", "pillar"))

# Base packages
pak::pak_install_extra()

pak::pkg_install("rspm")
pak::pkg_install("renv")
pak::pkg_install("cranlogs")
pak::pkg_install("remotes")
pak::pkg_install("languageserver")
pak::pkg_install("jsonlite")

rspm::enable()

required_packages <- c(
    "sf", 
    "imager", 
    "tidymodels", 
    "tidyverse", 
    "arrow", 
    "duckdb",
    "plotly",
    "quarto",
    "rmarkdown",
    "aws.s3",
    "reticulate",
    "remotes")

top_packages <- cranlogs::cran_top_downloads(when = "last-month", count = 100)

packages <- c(required_packages, top_packages$package)

sysreqs <- pak::pkg_sysreqs(packages)

fileConn <- "R_apt_deps.sh"
cat(sysreqs$pre_install, "\n", file = fileConn, append = FALSE)
cat(sysreqs$install_scripts, "\n", file = fileConn, append = TRUE)
cat(sysreqs$post_install, "\n", file = fileConn, append = TRUE)