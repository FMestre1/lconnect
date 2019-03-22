#' @title Prioritization of patches
#' @description Prioritization of patches according to individual contribution 
#' to overall connectivity. 
#' @param landscape lconnect object created by \code{\link{upload_land}}
#' @param metric string indicating the connectivity metric to use in the 
#' prioritization
#' @param vector_out TRUE/FALSE indicating if the resulting spatial object 
#' should be recorded to file
#' @usage patch_imp(landscape, metric, vector_out = F)
#' @return an object of class "pimp". This object is a list with the
#' following values:
#' \item{landscape}{spatial polygon object of class "sf" with cluster identity 
#' and importance of each polygon}
#' \item{prioritization}{vector with patch importance}
#' @details Each patch is removed at a time and connectivity 
#' metrics are recalculated without that specific patch. Patch importance value
#' indicates the percentage of reduction in the connectivity metric that the 
#' loss of that patch represents in the landscape. The current version only 
#' allows the use of IIC.
#' @references Saura, S., Pascual-Hortal, L. (2007). A new habitat 
#' availability index to integrate connectivity in landscape conservation planning: 
#' Comparison with existing indices and application to a case study. Landscape and
#' Urban Planning, 83(2-3):91-103.
#' @examples vec_path <- system.file("extdata/vec_projected.shp", package = "lconnect")
#' landscape <- upload_land(vec_path, bound_path = NULL,
#'                         habitat = 1, max_dist = 500)
#' importance <- patch_imp(landscape, metric = "IIC")
#' plot(importance)
#' @author Frederico Mestre
#' @author Bruno Silva
#' @export
#' @exportClass lconnect

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
    sf::st_write(landscape$landscape, "patches.shp",quiet = TRUE, 
                 driver = "ESRI Shapefile", delete_layer = TRUE)
    message("The vector file with the information on patch prioritization
            was saved to the working directory!")  
  }
  result <- list(landscape = landscape$landscape, prioritization = dCONN)
  class(result)<- "pimp"
  print(dCONN)
  return(result)
}

