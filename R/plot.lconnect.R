#' @title Plot object of class "lconnect"
#' @description Method of the generic \code{\link[graphics]{plot}} for objects 
#' of class "lconnect".
#' @param x Object of class "lconnect" created by \code{\link{upload_land}}.
#' @param ... Other options passed to \code{\link[graphics]{plot}} or
#' or \code{\link[sf]{plot.sf}}.
#' @details Plot patches with different colours representing cluster membership. 
#' Additional arguments accepted by '\code{\link[graphics]{plot}} or 
#' \code{\link[sf]{plot.sf}} can be included.
#' @return Plot depicting patches and cluster membership (distinct colours per 
#' cluster).
#' @method plot lconnect
#' @S3method plot lconnect
#' @author Bruno Silva
#' @author Frederico Mestre
plot.lconnect <- function(x, ...){
  x$landscape$clusters <- as.factor(x$landscape$clusters)
  # xmin <- sf::st_bbox(x$landscape)[1]
  # xmax <- sf::st_bbox(x$landscape)[3]
  # ymin <- sf::st_bbox(x$landscape)[2]
  # ymax <- sf::st_bbox(x$landscape)[4]
  # xlim <- c(xmin, xmax)
  # ylim <- c(ymin, ymax)
  # print(xlim)
  # print(ylim)
  graphics::plot(x$landscape,  key.pos = NULL, border = NA, reset = F, ...)
  graphics::plot(x$boundary,  add = T, col = scales::alpha("white", alpha = 0),
                 border = "grey", ...)
}
