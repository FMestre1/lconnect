#' patch_imp
#' @title Prioritization of patches according to individual contribution
#' @description Prioritization of patches according to individual contribution 
#' to overall connectivity. Each patch is removed at a time and connectivity 
#' metrics are calculated without that specific patch.
#' @param landscape lconnect object produced by upload_land()
#' @param metric string indicating the landscape metric to use in the 
#' prioritization. Must be one of "XX", "XX" .....
#' @usage patch_imp(landscape, metric)
#' @return que valores a funcao retorna
#' @references artigos em que se baseia a funcao
#' @author Frederico Mestre
#' @author Bruno Silva
#' @export

patch_imp <- function(landscape, metric, vector_out = F)
{
  if (!is.lconnect(landscape)) 
  {
    stop(paste0(landscape, " must be an object of class 'lconnect'."),
         call. = FALSE)
  }

#compute full landscpe metrics
full_conn <- as.numeric(con_metric(landscape, metric)) #este as.numeric tem de vir já da con_metric

npatch <- length(landscape$landscape$geometry)

dCONN <- rep(NA, npatch)#results vector

for (i in 1:npatch){

land1 <- landscape #landscape #This is just no to change landscape

land2 <- remove_patch(land1, i) #removing patch i
  
  #tem de se tirar uma mancha
  #re-calcular a área dos componentes

partial_conn <- as.numeric(con_metric(landscape=land2, metric))

dCONN[i] <- 100*((full_conn - partial_conn) / full_conn)#send the result to the vector

}

if (vector_out){
  
#shape out
landscape$landscape$attributes<-dCONN
  
sf::st_write(landscape$landscape, "patches.shp",quiet = TRUE, driver = "ESRI Shapefile", delete_layer = TRUE)

message("The vector file with the information on patch prioritization was saved to the working directory!")  

}

return(dCONN)

}

