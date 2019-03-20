#http://pierreroudier.github.io/teaching/20170626-Pedometrics/20170626-soil-data.html
land_path <- "~/Projectos/lconnect/inst/extdata/vec_projected.shp"

land <- upload_land(land_path, habitat = 1, min_dist =500)

plot(land$landscape)

nc <- st_read(vec_path)
plot(nc)

u <- st_union(nc)
plot(u)
