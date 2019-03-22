#' is.pimp
#' @title Test for class pimp
#' @description Tests if an object belongs to pimp class 
#' @param x object to test
#' @usage is.pimp(x)
#' @return TRUE/FALSE
#' @author Bruno Silva
#' @author Frederico Mestre
#' @export
is.pimp <- function(x) inherits(x, "pimp")