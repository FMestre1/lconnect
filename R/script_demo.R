library(lconnect)

vec_path <- system.file("extdata/vec_projected.shp", package = "lconnect")

landscape <- upload_land(vec_path, bound_path = NULL, habitat = 1, max_dist = 500)
plot(landscape)

con_metric(landscape, metric="PC", beta1 = 1)

importance <- patch_imp(landscape, metric = "PC", beta1 = 1)
importance2 <- patch_imp(landscape, metric = "AWF")
importance3 <- patch_imp(landscape, metric = "IIC")


plot(importance)
plot(importance2)
plot(importance3)


decompose_PC <- function(landscape, beta1){
  
  pc <- patch_imp(landscape, metric = "PC", beta)
  pc1 <- pc$prioritization
  areas <- pc$landscape
  
  aux <- component_calc(landscape$landscape, landscape$distance,
                        landscape$max_dist)
  
  clusters <- aux$clusters
  area_c <- as.numeric(aux$area_c)
  area_l <- as.numeric(landscape$area_l)
  max_dist <- landscape$max_dist
  distance <- landscape$distance
  
  
}

