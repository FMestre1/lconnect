#' upload.landscape
#' @title Dsn and layer name from .shp filepath
#' @description Creates a valid dsn and layer name from a .shp filepath
#' @param path The full path of the landscape file
#' @param vec Boolean. TRUE if file is a shapefile, FALSE
#' if is a raster.
#' @usage upload.landscape(path, vec)
#' @return A SpatialPolygonsDataFrame object is returned.
#' @author Bruno Silva
#' @export
upload.landscape <- function(path, vec = TRUE){

  if(vec){
  dsn <- strsplit(path, "/|[\\]")[[1]]
  dsn <- paste(dsn[-c(length(dsn))], collapse = "/")

  layer <- strsplit(path, "/|[\\]")[[1]]
  layer <- layer[length(layer)]
  layer <- strsplit(as.character(layer), "\\.")[[1]][1]

 landscape <- rgdal::readOGR(dsn = dsn, layer = layer)
  } else {
    landscape <- raster(path)
    landscape <- rasterToPolygons(landscape) # introduzir algumas opcoes desta conversao nos argumentos da funcao upload.landscape
}
 return(landscape)
}
