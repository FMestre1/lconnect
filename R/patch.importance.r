#' patch_imp
#' @title
#' @description
#' Patch prioritization according to individual patch contribution to
#' overall connectivity
#' @param landscape lconnect object produced by upload_land()
#' @param metric landscape metric to use in the prioritization
#' @usage patch_imp (landscape, metric)
#' @return que valores a funcao retorna
#' @examples exemplos de aplicacao com dados fornecidos pelo package
#' @references artigos em que se baseia a funcao
#' @author Frederico Mestre
#' @author Bruno Silva
#' @export

patch_imp <- function(landscape, metric, vector.out = F)
{
  if (!is.lconnect(landscape)) 
  {
    stop(paste0(landscape, " must be an object of class 'lconnect'."),
         call. = FALSE)
  }

#compute full landscpe metrics
full.CONN <- as.numeric(l.metric(landscape, landscape$min_dist, metric))

npatch <- length(landscape$landscape$geometry)

dCONN <- rep(NA, npatch)#results vector

for (i in 1:npatch){

land1 <- landscape #landscape #This is just no to change landscape

land2 <- remove_patch(land1, i) #removing patch i
  
  #tem de se tirar uma mancha
  #refazer o convex hull
  #re-calcular a área total
  #re-calcular a área dos componentes

partial.CONN <- as.numeric(l.metric(landscape=land2, landscape$min_dist, metric))

dCONN[i] <- 100*((full.CONN-partial.CONN)/full.CONN)#send the result to the vector

}

if (vector.out==TRUE){
  
#shape out
landscape$landscape$attributes<-dCONN
  
st_write(landscape$landscape, "patches.shp",quiet = TRUE, driver = "ESRI Shapefile", delete_layer = TRUE)

message("The vector file with the information on patch prioritization was saved to the working directory!")  

}

return(dCONN)

}

