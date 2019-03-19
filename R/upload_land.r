#' upload_land
#' @title Import and convert a shapefile to a lconnect object
#' @description Import and convert a shapefile to a lconnect object. Some
#' landscape and patch metrics which are the core of landscape connectivity
#' metrics are calculated. The shapefile must be projected, i.e., in planar 
#' coordinates and the first field must be contain the habitat categories.
#' @param land_path string, indicating the full path of the landscape shapefile.
#' @param bound_path string, indicating the full path of the boundary shapefile.
#' If NULL (default option) a convex hull will be created and used as boundary.
#' @param habitat vector with habitat categories. The categories can be numeric
#' or character.
#' @usage upload_land(land_path, bound_path = NULL, habitat, min_dist = NULL)
#' @return A lconnect object is returned.
#' @examples vec_path <- system.file("extdata/vector.shp", package = "lconnect")
#' landscape <- upload_land(vec_path, bound_path = NULL,
#'  habitat = 1, min_dist = NULL)
#' @author Bruno Silva
#' @author Frederico Mestre
#' @export
upload_land <- function(land_path, bound_path = NULL, habitat, min_dist = NULL){
  landscape <- sf::st_read(land_path, quiet = T)
  landscape <- landscape[landscape[[2]] == habitat,]
  landscape <- sf::st_union(landscape)
  if(is.null(bound_path)){
    boundary <- sf::st_convex_hull(landscape)
  } else{
    boundary <- sf::st_read(bound_path, quiet = T)
  }
  area_l <- sf::st_area(boundary)
  landscape <- sf::st_cast(landscape, "POLYGON")
  area_c <- sf::st_area(landscape)
  distance <- sf::st_distance(landscape)
  distance <- as.dist(distance)
  if(is.null(min_dist)){
    clusters <- rep(1, length(landscape)) 
  } else{
    groups <- hclust(distance, "single")
    clusters <- cutree(groups, h = min_dist)
  }
  landscape <- suppressWarnings(st_sf(clusters = clusters, 
                                      geometry = landscape))
  object <- list(landscape = landscape, distance = distance, 
                 boundary = boundary, area_c = area_c, area_l = area_l)
  class(object) <- "lconnect"
  return(object)
}
