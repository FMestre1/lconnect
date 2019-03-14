vec_path <- "~/Projectos/lconnect/inst/extdata/vec_projected.shp"

land <- upload.landscape(vec_path)
land <- land[land[[2]] == 1 ,]
land_sf<-st_as_sf(land)
system.time(dist <- st_distance(land_sf))



