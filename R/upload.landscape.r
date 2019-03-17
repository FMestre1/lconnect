#' upload.landscape
#' @title Dsn and layer name from .shp filepath
#' @description Creates a valid dsn and layer name from a .shp filepath.
#' The .shp must be projected, i.e., in planar coordinates
#' @param land_path The full path of the landscape file
#' #' @param bound_path The full path of the boundary file.
#' If NULL (default option) a convex hull will be created
#' and used as boundary
#' @param habitat Vector with habitat categories.
#' @usage upload.landscape(land_path, habitat)
#' @return A SpatialPolygonsDataFrame object is returned.
#' @examples vec_path <- system.file("extdata/vector.shp", package = "lconnect")
#' rast_path <- system.file("extdata/vector.tiff", package = "lconnect")
#' landscape <- upload.landscape(vec_path)
#' landscape <- upload.landscape(rast_path, vec = FALSE)
#' @author Bruno Silva
#' @export
upload.landscape <- function(land_path, bound_path = NULL, habitat){ # , boundary = F
  dsn <- strsplit(land_path, "/|[\\]")[[1]]
  dsn <- paste(dsn[-c(length(dsn))], collapse = "/")
  layer <- strsplit(land_path, "/|[\\]")[[1]]
  layer <- layer[length(layer)]
  layer <- strsplit(as.character(layer), "\\.")[[1]][1]
  landscape <- rgdal::readOGR(dsn = dsn, layer = layer, verbose = FALSE)
  landscape <- landscape[landscape[[2]] == habitat ,]
  landscape <- unionSpatialPolygons(landscape, IDs=landscape[[2]])
  landscape <- sf::st_as_sf(landscape)
  if(is.null(bound_path)){
    boundary <- sf::st_convex_hull(landscape)
  } else {
    dsn <- strsplit(bound_path, "/|[\\]")[[1]]
    dsn <- paste(dsn[-c(length(dsn))], collapse = "/")
    layer <- strsplit(bound_path, "/|[\\]")[[1]]
    layer <- layer[length(layer)]
    layer <- strsplit(as.character(layer), "\\.")[[1]][1]
    boundary <- rgdal::readOGR(dsn = dsn, layer = layer, verbose = FALSE)
  }
  area_l <- sf::st_area(boundary)
  landscape <- sf::st_cast(landscape, "POLYGON")
  area_c <- sf::st_area(landscape)
  distance <- sf::st_distance(landscape)
  object <- list(landscape = landscape, distance = distance, boundary = boundary,
                  area_c = area_c, area_l = area_l)
  class(object) <- "lconnect"
  return(object)
}
