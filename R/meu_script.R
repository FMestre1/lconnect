#load packages
library(maptools)
library(sp)
library(raster)
library(sf)
library(units)
library(igraph)

#load functions
source("D:/lconnect/R/patch_imp.r")
source("D:/lconnect/R/plot.r")
source("D:/lconnect/R/remove_patch.r")
source("D:/lconnect/R/upload_land.r")
source("D:/lconnect/R/is.lconnect.R")
source("D:/lconnect/R/con_metric.r")
source("D:/lconnect/R/component_calc.r")


#Load data
vec_path <- ("D:/lconnect/inst/extdata/vec_projected.shp")

#upload landscape
land <- upload_land(vec_path, habitat = 1, min_dist = 250)
names(land)

landscape <- land

plot(land)

#label
centr <- st_centroid(land$landscape)
c1<-st_coordinates(centr)
text(x=c1[,1], y=c1[,2], land$clusters, pos=2)

#label patches
text(x=c1[,1], y=c1[,2], rownames(land$landscape),col="red")


class(land)

#Connectivity metrics
con_metric(land, metric="CCP")

patch.imp(land, metric="LCP", vector.out=FALSE)


