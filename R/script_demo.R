library(lconnect)

vec_path <- system.file("extdata/vec_projected.shp", package = "lconnect")

landscape <- upload_land(vec_path, bound_path = NULL, habitat = 1, max_dist = 500)
plot(landscape)

landscape_minus_4 <- remove_patch(landscape, 4)
plot(landscape_minus_4)

##
#Test negative
pc_T <- con_metric(landscape, metric="PC", beta1 = 1)
pc_R <- con_metric(landscape_minus_4, metric="PC", beta1 = 1)

((pc_T-pc_R)/pc_T)*100
##

importance <- patch_imp(landscape, metric = "PC", beta1 = 1)
importance2 <- patch_imp(landscape, metric = "AWF")
importance3 <- patch_imp(landscape, metric = "IIC")

plot(landscape)
centroids <- sf::st_centroid(importance$landscape$geometry)
centroids2 <- sf::st_coordinates(centroids)
centroids3 <- as.data.frame(centroids2)

plot(landscape, main="Landscape clusters", at=centroids3)
#text(x = centroids3$X, y = centroids3$Y, labels = landscape$landscape$clusters) # add text
text(x = centroids3$X, y = centroids3$Y, labels = round(importance$prioritization,3)) # add text

#ATENÇÃO: Ao remover manchas do exterior, usando a bounding box estamos a afectar o Al.

plot(importance)
plot(importance2)
plot(importance3)

decompose_PC <- function(landscape, beta1){
  

  
  
}

