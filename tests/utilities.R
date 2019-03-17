#http://pierreroudier.github.io/teaching/20170626-Pedometrics/20170626-soil-data.html
vec_path <- "~/Projectos/lconnect/inst/extdata/vec_projected.shp"

land <- upload.landscape(vec_path, habitat = 1)

plot(land$landscape)
