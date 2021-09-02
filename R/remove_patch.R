#' @keywords internal
remove_patch <- function(object, patch) {
  l1 <- object
  area_l <- l1$area_l
  landscape <- object$landscape$geometry[-c(patch)]
  distance <- sf::st_distance(landscape)
  distance <- stats::as.dist(distance)
  aux <- component_calc(landscape, distance, l1$max_dist)
  landscape <- suppressWarnings(sf::st_sf(clusters = aux$clusters, geometry = landscape))
  object <- list(landscape = landscape, max_dist = max_dist,
                 clusters = aux$clusters, distance = distance,
                 boundary = l1$boundary, area_l = area_l)
  class(object) <- "lconnect"
  return(object)
}
