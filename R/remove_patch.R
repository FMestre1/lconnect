#' @keywords internal
remove_patch <- function(object, patch)
{
  object$landscape <- object$landscape$geometry[-c(patch)]
  object$distance <- as.matrix(object$distance)[-c(patch),-c(patch)]
  object$distance <- as.dist(object$distance)
  object$area_c <- object$area_c[-c(patch)]
  return(object)
}