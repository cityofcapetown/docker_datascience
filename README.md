# docker_datascience

This docker image is based on `Ubuntu 18.04`.

It contains the following environments, installed according to each project's documented installation instructions:

1. `Jupyterhub` with `jupyter lab` enabled
2. `RStudio Server` with `MikTex`
3. `Shiny Server` * TO DO: SERVE APPS FROM /home/<user>/ShinyApps folders...
4. `h2o`

It also has a whole lot of `R` and `python` packages installed. For a list, look at the `python_additions.sh` and `R_additions.R` files.

## Usage

The default user has sudo privileges. The default username is `newuser` and the password is `password`.

To change the defaults, change the environment variables `$NEWUSER` and `$PASSWD` -

```
docker run -rm \
-e NEWUSER=neweruser \
-e PASSWD=newpassword \
riazarbi/docker_datascience
```

None of these environments are configured to spin up at runtime. Rather, use enviroment flags to enable services. You'll need to map the ports as well. For instance -

```
<first part of docker command>
-e JUPYTER=yes \
-e RSTUDIO=yes \
-e SHINY=yes \
-p 8000:8000 # jupyterhub \
-p 8787:8787 # rstudio \
-p 3838:3838 # shiny
riazarbi/docker_datascience
```
**Note:** There is no flag to spin up h2o, because the h2o jar wants you to specify RAM allocation at runtime. So rather spin it up from an R or python script.

You can clone a git repository into the `$NEWUSER` home directory by specifying the url. 

If you don't specify a directory, it will clone in the default, which is `https://github.com/riazarbi/workspace_template.git`.

So a command that uses all the options is - 

```
docker run -rm \
-e NEWUSER=neweruser \
-e PASSWD=newpassword \
-e JUPYTER=yes \
-e RSTUDIO=yes \
-e SHINY=yes \
-p 8000:8000 # jupyterhub \      
-p 8787:8787 # rstudio \          
-p 3838:3838 # shiny \     
-p 54321:54321 # h2o if you want other hosts to access, or clustering\
-p 54322:54321 # h2o if you want other hosts ot access, or clustering\
-e GIT_REPO=https://github.com/riazarbi/workspace_template.git \
riazarbi/docker_datascience'
```
