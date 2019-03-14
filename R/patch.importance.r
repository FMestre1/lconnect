#' patch.importance
#' @title
#' @description
#' Patch prioritization according to individual patch contribution to
#'  overall connectivity
#' @param landscape Landscape object produced by upload.landscape
#' @param metric Landscape metric to use in the prioritization
#' @usage patch.imp (landscape, metric)
#' @return que valores a funcao retorna
#' @examples exemplos de aplicacao com dados fornecidos pelo package
#' @references artigos em que se baseia a funcao
#' @author Frederico Mestre
#' @export

patch.imp <- function(landscape, metric)
{
#object from upload.landscape
#metric - metric to use in the prioritization

#compute full landscpe metrics
full.CONN <- as.numeric(l.metrics(landscape=landscape, metric))

dCONN <- c()#results vector
npatch <- #deriving the number of patches

for (i in 1:npatch){

land1 <- landscape #landscape #This is just no to change landscape

land2 <- #removing patch i

partial.CONN <- as.numeric(l.metrics(landscape=land2, metric))

dCONN[i] <- 100*((full.CONN-partial.CONN)/full.CONN)#send the result to the vector

}
return(dCONN)#get result
}
