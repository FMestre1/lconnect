#' con_metric
#' @title Landscape connectivity metrics
#' @description Calculates several landscape connectivity metrics
#' @param landscape landscape object produced by upload.landscape
#' @param metric vector of landscape metrics to be computed. Can be one or more of
#' the metrics currently available: "NC", "LNK", "SLC", "MSC", "CCP", "LCP",
#' "CPL", "ECS", "AWF" and "IC".  
#' @usage con_metric(landscape, metric)
#' @return vector with the selected metrics.
#' @examples vec_path <- system.file("extdata/vec_projected.shp", package = "lconnect")
#' landscape <- upload_land(vec_path, bound_path = NULL,
#' habitat = 1, min_dist = 500)
#' metrics <- con_metric(landscape, metric = c("NC", "LCP"))
#' @references Bunn, A. G., Urban, D. L., and Keitt, T. H. (2000). Landscape connectivity: a conservation application of graph theory. Journal of Environmental Management, 59(4): 265-278.
#' Fall, A., Fortin, M. J., Manseau, M., and O' Brien, D. (2007). Spatial graphs: principles and applications for habitat connectivity. Ecosystems, 10(3): 448-461.
#' Laita, A., Kotiaho, J.S., Monkkonen, M. (2011). Graph-theoretic connectivity measures: what do they tell us about connectivity? Landscape Ecology, 26: 951-967.
#' Minor, E. S., and Urban, D. L. (2008). A Graph-Theory Framework for Evaluating Landscape Connectivity and Conservation Planning. Conservation Biology, 22(2): 297-307.
#' O'Brien, D., Manseau, M., Fall, A., and Fortin, M. J. (2006). Testing the importance of spatial configuration of winter habitat for woodland caribou: an application of graph theory. Biological Conservation, 130(1): 70-83.
#' Pascual-Hortal, L., and Saura, S. (2006). Comparison and development of new graph-based landscape connectivity indices: towards the priorization of habitat patches and corridors for conservation. Landscape Ecology, 21(7): 959-967. 
#' Saura, S., and Pascual-Hortal, L. (2007). A new habitat availability index to integrate connectivity in landscape conservation planning: comparison with existing indices and application to a case study. Landscape and Urban Planning, 83(2): 91-103. 
#' Saura, S., Estreguil, C., Mouton, C. & Rodriguez-Freire, M. (2011a). Network analysis to assess landscape connectivity trends: application to European forests (1990-2000). Ecological Indicators 11: 407-416.
#' Saura, S., Gonzalez-Avila, S. & Elena-Rossello, R. (2011b). Evaluacion de los cambios en la conectividad de los bosques: el indice del area conexa equivalente y su aplicacion a los bosques de Castilla y Leon. Montes, Revista de Ambito Forestal 106: 15-21
#' Urban, D., and Keitt, T. (2001). Landscape connectivity: a graph-theoretic perspective. Ecology, 82(5): 1205-1218.
#' @author Frederico Mestre
#' @author Bruno Silva
#' @export
con_metric <- function(landscape, metric) {
  if (class(landscape) != "lconnect") 
  {
    stop("landscape must be an object of class class 'lconnect'.",
    call. = FALSE)
  }
  aux <- component_calc(landscape$landscape, landscape$distance, 
                        landscape$min_dist)
  clusters <- aux$clusters
  area_c <- as.numeric(aux$area_c)
  area_l <- as.numeric(landscape$area_l)
  min_dist <- landscape$min_dist
  distance <- landscape$distance
  NC <- max(clusters)
  result <- c()
  if("NC" %in% metric)
  {
    result <- c(result, NC = NC)
  }
  if("LNK" %in% metric)
  {
    result <- c(result, LNK = sum(distance < min_dist))
  }
    if("SLC" %in% metric)
  {
    df0 <- data.frame(area_c, clusters)
    Ac <- sum(area_c)
    r0 <- rep(NA, NC)
    for(i in 1:NC)
    {
      df1 <- df0[df0$clusters == i, ]
      ci <- sum(df1[,1])
      r0[i] <- ci
    }
    result <- c(result, SLC = max(r0))
  }
  if("MSC" %in% metric)
  {
    Ac <- sum(area_c)
    result <- c(result, MSC = Ac / NC)
  }
  if("CCP" %in% metric)
  {
    df0 <- data.frame(area_c, clusters)
    Ac <- sum(area_c)
    r0 <- rep(NA, NC)
    for(i in 1:NC)
    {
      df1 <- df0[df0$clusters == i, ]
      ci <- sum(df1[,1])
      r0[i] <- (ci / Ac)^2
    }
    result <- c(result, CCP = sum (r0))
  }
  if("LCP" %in% metric)
  {
    df0 <- data.frame(area_c, clusters)
    r0 <- rep(NA, NC)
    for(i in 1:NC)
    {
      df1 <- df0[df0$clusters==i, ]
      ci <- sum(df1[,1])
      r0[i] <- (ci/landscape$area_l)^2
    }
    result <- c(result, LCP = sum (r0))
  }
  if("CPL" %in% metric)
  {
    d1 <- upper.tri(as.matrix(distance))*as.matrix(distance)
    d1[d1==0]<-NA
    e1 <- as.data.frame(which(d1 < min_dist, arr.ind = TRUE, useNames = FALSE))
    g1 <- igraph::graph_from_data_frame(e1, directed = FALSE)
    short_p <- igraph::shortest.paths(g1)
    n_links <- (sum(!is.infinite(short_p)) - nrow(short_p))/2
    filt <- which(!is.infinite(short_p))
    sum_links <- sum(short_p[filt])/2
    result <- c(result, CPL = sum_links/n_links)
    }
  if("ECS" %in% metric)
  {
    df0 <- data.frame(area_c, clusters)
    Ac <- sum(area_c)
    r0 <- rep(NA, NC)
    for(i in 1:NC)
    {
      df1 <- df0[df0$clusters==i, ]
      ci <- sum(df1[,1])
      r0[i] <- ci^2
    }
    result <- c(result, ECS = sum(r0) / Ac)
  }
  if("AWF" %in% metric)
  {
    k <- -(log(0.5) / (min_dist / 2))
    out <- matrix(NA, nrow = length(area_c), ncol = length(area_c))
    for(i in 1:length(area_c)){
      for(j in 1:length(area_c)){
        prob <- exp(-k * (as.matrix(distance)[i, j])) * area_c[i] * area_c[j]
        out[i, j] <- prob
    }
  } 
    diag(out) <- 0
    result <- c(result, AWF = sum(out))
   }
  if("IIC" %in% metric)
  {
    d1 <- upper.tri(as.matrix(distance)) * as.matrix(distance)
    d1[d1 == 0] <- NA
    e1 <- as.data.frame(which(d1 < min_dist, arr.ind = TRUE, useNames = FALSE))
    e2 <- cbind(e1[, 2], e1[, 1])
    g1 <- igraph::graph_from_data_frame(e1, directed = FALSE)
    short_p <- igraph::shortest.paths(g1)
    out <- matrix(NA, nrow = length(area_c), ncol = length(area_c))
    for(i in as.numeric(row.names(short_p))){
      for(j in as.numeric(row.names(short_p))){
        nij <- short_p[as.character(i), as.character(j)]
        prob <- (area_c[i] * area_c[j]) / (1 + nij)
        out[i, j] <- prob
      }
    }    
    out[is.na(out)] <- 0
    result <- c(result, IIC = (sum(out) / (area_l^2)))
  }
  return(round(result, 5))
}
