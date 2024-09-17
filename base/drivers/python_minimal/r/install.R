# Base packages
install.packages(c("pak", "pillar"))

# Base packages
pak::pak_install_extra()

pak::pkg_install(c("rspm", "renv", "cranlogs", "remotes"))

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
    "reticulate")

top_packages <- cranlogs::cran_top_downloads(when = "last-month", count = 100)

packages <- c(required_packages, top_packages$package)

sysreqs <- pak::pkg_sysreqs(packages)

fileConn <- "R_apt_deps.sh"
cat(sysreqs$pre_install, "\n", file = fileConn, append = FALSE)
cat(sysreqs$install_scripts, "\n", file = fileConn, append = TRUE)
cat(sysreqs$post_install, "\n", file = fileConn, append = TRUE)