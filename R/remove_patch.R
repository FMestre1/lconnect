#' @keywords internal
remove_patch <- function(object, patch) {
  object$landscape <- object$landscape$geometry[-c(patch)]
  object$distance <- as.matrix(object$distance)[-c(patch), -c(patch)]
  object$distance <- stats::as.dist(object$distance)
  return(object)
}
