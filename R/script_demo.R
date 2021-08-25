library(lconnect)

vec_path <- system.file("extdata/vec_projected.shp", package = "lconnect")

landscape <- upload_land(vec_path, bound_path = NULL, habitat = 1, max_dist = 500)
plot(landscape)

importance <- patch_imp(landscape, metric = "PC", beta1 = 2)
importance2 <- patch_imp(landscape, metric = "AWF")
importance3 <- patch_imp(landscape, metric = "IIC")

plot(importance)
plot(importance2)
plot(importance3)
