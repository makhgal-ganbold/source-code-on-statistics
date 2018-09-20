#
# Package Development
# Author: galaa
# Created on 2016/06/10 20:59:41
#

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Library dependence
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# install.packages(c("devtools", "roxygen2"), repos = "https://cran.rstudio.com")

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Create a package
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

devtools::create("izbali")

setwd("./izbali")

# Edit DESCRIPTION file

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Add some functions
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Create "edf.R" file in "R" folder

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Compile documentation and Reload the package
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

devtools::document()

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Check the package
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

devtools::check()

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Build the package
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

devtools::build()
