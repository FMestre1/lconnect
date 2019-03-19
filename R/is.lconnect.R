#' is.lconnect
#' @title 
#' @description Tests if an object belongs to lconnect class 
#' @param x object to test
#' @usage is.lconnect(x)
#' @return TRUE/FALSE
#' @author Bruno Silva
#' @author Frederico Mestre
#' @export
is.lconnect <- function(x) inherits(x, "lconnect")