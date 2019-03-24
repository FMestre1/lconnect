#' @title Import and convert a shapefile to an object of class "lconnect"
#' @description Import and convert a shapefile to an object of class "lconnect". 
#' Some landscape and patch metrics which are the core of landscape connectivity
#' metrics are calculated. The shapefile must be projected, i.e., in planar 
#' coordinates and the first field must contain the habitat categories.
#' @param land_path String indicating the full path of the landscape shapefile.
#' @param bound_path String indicating the full path of the boundary shapefile.
#' If NULL (default option) a convex hull will be created and used as boundary.
#' @param habitat Vector with habitat categories. The categories can be numeric
#' or character.
#' @param max_dist Numeric indicating the maximum distance between patches in 
#' the same cluster. 
#' @usage upload_land(land_path, bound_path = NULL, habitat, max_dist = NULL)
#' @return An object of class "lconnect". This object is a list with the
#' following values:
#' \item{landscape}{Spatial polygon object of class "sf" (package "sf") with 
#' cluster membership of each polygon.}
#' \item{max_dist}{Numeric indicating the maximum distance between patches 
#' of the same cluster.}
#' \item{clusters}{Numeric vector indicating cluster identity of each polygon.}
#' \item{distance}{Object of class "dist" (package "stats") with eucledian 
#' distances between all pairs of polygons.}
#' \item{boundary}{Spatial polygon of class "sfc" (package "sf") representing 
#' the boundary of the landscape.}
#' \item{area_l}{Numeric with the total area of the boundary, in square units 
#' of landscape units.}
#' @examples vec_path <- system.file("extdata/vec_projected.shp", 
#' package = "lconnect")
#' landscape <- upload_land(vec_path, bound_path = NULL,
#' habitat = 1, max_dist = 500)
#' plot(landscape)
#' @author Bruno Silva
#' @author Frederico Mestre
#' @export
#' @exportClass lconnect
upload_land <- function(land_path, bound_path = NULL, habitat, max_dist = NULL){
  if (!is.character(land_path)) {
    stop(paste0("Argument 'land_path' must be a string"),
         call. = FALSE)
  }
  if (!utils::file_test("-f", land_path)) {
    stop(paste0("Argument 'land_path' doesn't seem to be a valid file"),
         call. = FALSE)
  }
  if (!is.character(bound_path) & !is.null(bound_path)) {
    stop(paste0("Argument 'bound_path' must be NULL or a string"),
         call. = FALSE)
  }
  if (is.character(bound_path)) {
    if (!utils::file_test(bound_path)) {
      stop(paste0("Argument 'bound_path' doesn't seem to be a valid file"),
           call. = FALSE)
    }
  }
  if (!is.numeric(max_dist) & !is.null(max_dist)) {
    stop(paste0("Argument 'max_dist' must be NULL or numeric"),
         call. = FALSE)
  }
  if (length(max_dist) > 1) {
    stop(paste0("Argument 'max_dist' must be a single number"),
         call. = FALSE)
  }
  landscape <- sf::st_read(land_path, quiet = T)
  landscape <- landscape[landscape[[1]] == habitat, ]
  landscape <- sf::st_union(landscape)
  if (is.null(bound_path)) {
    boundary <- sf::st_convex_hull(landscape)
  } else{
    boundary <- sf::st_read(bound_path, quiet = T)
  }
  area_l <- sf::st_area(boundary)
  landscape <- sf::st_cast(landscape, "POLYGON")
  distance <- sf::st_distance(landscape)
  distance <- stats::as.dist(distance)
  aux <- component_calc(landscape, distance, max_dist)
  landscape <- suppressWarnings(sf::st_sf(clusters = aux$clusters,
                                      geometry = landscape))
  object <- list(landscape = landscape, max_dist = max_dist,
                 clusters = aux$clusters, distance = distance,
                 boundary = boundary, area_l = area_l)
  class(object) <- "lconnect"
  return(object)
}
