#' @title Plot pimp object
#' @description Method of the generic \code{\link[graphics]{plot}} for 
#' objects of class "pimp".
#' @param x Object of class "pimp" created by \code{\link{patch_imp}}.
#' @param ... Other options passed to \code{\link[graphics]{plot}} or 
#' \code{\link[sf]{plot.sf}}.
#' @param main String with plot title.
#' @return Patch importance plot.
#' @method plot pimp
#' @S3method plot pimp
#' @author Bruno Silva
#' @author Frederico Mestre
#' @details Plot patch importance with percentage value per patch. This value
#' indicates the percentage of reduction in the connectivity metric that the 
#' loss of that patch represents in the landscape. Additional arguments accepted
#' by \code{\link[graphics]{plot}} or \code{\link[sf]{plot.sf}} can be included.
plot.pimp <- function(x, ..., main){
  if (missing(main)) {
    main <- "Importance (%)"
  }
  graphics::plot(x$landscape["attributes"], border = NA,
                 main = main, ...)
}
