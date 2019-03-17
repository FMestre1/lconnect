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

patch.imp <- function(landscape, dist_min, metric, vector.out=F)
{
#object from upload.landscape
#metric - metric to use in the prioritization

#compute full landscpe metrics
full.CONN <- as.numeric(l.metric(landscape, dist_min, metric))

npatch <- length(landscape$landscape$geometry)

dCONN <- rep(NA, npatch)#results vector

for (i in 1:npatch){

land1 <- landscape #landscape #This is just no to change landscape

land2 <- remove_patch(land1, i) #removing patch i
  
  #tem de se tirar uma mancha
  #refazer o convex hull
  #re-calcular a área total
  #re-calcular a área dos componentes

partial.CONN <- as.numeric(l.metric(landscape=land2, dist_min, metric))

dCONN[i] <- 100*((full.CONN-partial.CONN)/full.CONN)#send the result to the vector

}

if (vector.out=TRUE){
  
#shape out
  
st_write(landscape$landscape, "patches.shp",quiet = TRUE, driver = "ESRI Shapefile", delete_layer = TRUE)


message("The vector file with the information on patch prioritization was saved to the working directory!")  

}

return(round(dCONN,3))#get result
}
