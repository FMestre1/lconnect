#' upload.landscape
#' @title Dsn and layer name from .shp filepath
#' @description Creates a valid dsn and layer name from a .shp filepath.
#' The .shp must be projected, i.e., in planar coordinates
#' @param path The full path of the landscape file
#' @param habitat Vector with habitat categories.
#' @usage upload.landscape(path, habitat)
#' @return A SpatialPolygonsDataFrame object is returned.
#' @examples vec_path <- system.file("extdata/vector.shp", package = "lconnect")
#' rast_path <- system.file("extdata/vector.tiff", package = "lconnect")
#' landscape <- upload.landscape(vec_path)
#' landscape <- upload.landscape(rast_path, vec = FALSE)
#' @author Bruno Silva
#' @export
upload.landscape <- function(path, habitat){
  
  dsn <- strsplit(path, "/|[\\]")[[1]]
  dsn <- paste(dsn[-c(length(dsn))], collapse = "/")
  
  layer <- strsplit(path, "/|[\\]")[[1]]
  layer <- layer[length(layer)]
  layer <- strsplit(as.character(layer), "\\.")[[1]][1]
  
  landscape <- rgdal::readOGR(dsn = dsn, layer = layer)
  
  landscape <- landscape[landscape[[2]] == habitat ,]
  landscape <- unionSpatialPolygons(landscape, IDs=land[[2]])
  
  landscape <- sf::st_as_sf(landscape)
  landscape <- sf::st_cast(landscape, "POLYGON")
  
  area <- sf::st_area(landscape)
  
  distance <- sf::st_distance(landscape)
  
  object <- list(landscape = landscape, distance = distance, area = area)
  
  class(object) <- "lconnect"
  
  return(object)
}
