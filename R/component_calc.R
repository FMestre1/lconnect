#' @keywords internal
component_calc <- function(object, distance, min_dist = NULL) {
  if (is.null(min_dist)){
    clusters <- rep(1, length(object))
  } else{
    groups <- stats::hclust(distance, "single")
    clusters <- stats::cutree(groups, h = min_dist)
  }
  area_c <- sf::st_area(object)
  return(list(area_c = area_c, clusters = clusters))
}
