#' patch_imp
#' @title Prioritization of patches according to individual contribution
#' @description Prioritization of patches according to individual contribution 
#' to overall connectivity. Each patch is removed at a time and connectivity 
#' metrics are calculated without that specific patch.
#' @param landscape lconnect object produced by upload_land()
#' @param metric string indicating the landscape metric to use in the 
#' @param vector_out TRUE/FALSE
#' prioritization. The current version only allows the use of IIC.
#' @usage patch_imp(landscape, metric)
#' @return Returns a vector depicting each patch's importance to overall 
#' connectivity.
#' @references #' Saura, S., Pascual-Hortal, L. (2007). A new habitat availability index to integrate connectivity in landscape conservation planning: Comparison with existing indices and application to a case study. Landscape and Unrban Planning, 83(2-3):91-103.
#' @author Frederico Mestre
#' @author Bruno Silva
#' @export

patch_imp <- function(landscape, metric, vector_out = F)
{
  if (!is.lconnect(landscape)) 
  {
    stop(paste0("Landscape must be an object of class 'lconnect'."),
         call. = FALSE)
  }
  
  if (metric!="IIC") 
  {
    stop(paste0("The argument 'metric' must use only the IIC metric."),
         call. = FALSE)
  }

#compute full landscpe metrics
full_conn <- con_metric(landscape, metric)

npatch <- length(landscape$landscape$geometry)

dCONN <- rep(NA, npatch)

for (i in 1:npatch){

land1 <- remove_patch(landscape, i)

partial_conn <- as.numeric(con_metric(landscape=land1, metric))

dCONN[i] <- 100*((full_conn - partial_conn) / full_conn)
}

landscape$landscape$attributes<-dCONN
if (vector_out){
  

  
sf::st_write(landscape$landscape, "patches.shp",quiet = TRUE, driver = "ESRI Shapefile", delete_layer = TRUE)

message("The vector file with the information on patch prioritization was saved to the working directory!")  

}

result <- list(landscape = landscape$landscape, prioritization = dCONN)

class(result)<- "pimp"

print(dCONN)

return(result)

}

