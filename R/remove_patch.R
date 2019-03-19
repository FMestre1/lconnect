#' @keywords internal
remove_patch <- function(object, patch)
{
  object$landscape <- object$landscape$geometry[-patch]
  object$distance <- object$distance[-patch,-patch] # mudar. ja nao e uma matriz de distancias mas sim um objecto dist
  object$area_c <- object$area_c[-patch]
  return(object)
}