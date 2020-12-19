#
# Remove Manually Installed Packages
# Author: Galaa
# Created on 2020/12/19 10:35:00
#

# Retrieve a list of all installed packages -------------------------------

pckgs <- as.data.frame(x = installed.packages(), stringsAsFactors = FALSE)

# Exclude core packages ---------------------------------------------------

pckgs <- subset(x = pckgs, subset = !{Priority %in% c("base", "recommended")}, select = c("Package", "LibPath"))

# Uninstall packages ------------------------------------------------------

remove.packages(pkgs = pckgs$Package, lib = pckgs$LibPath)
