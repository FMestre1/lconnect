package.name <- "lconnect"
package.dir <- paste0("~/Projectos/", package.name)
setwd(package.dir)
### --- Use Roxygenise to generate .RD files from comments
library(roxygen2)
roxygenise(package.dir = package.dir)
system(command = paste("R CMD INSTALL '", package.dir, "'", sep=""))
